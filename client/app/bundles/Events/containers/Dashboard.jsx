import React, { Component } from 'react';
import Breadcrumbs from '../components/Breadcrumbs';
import { connect } from 'react-redux';

import Nav from '../components/Nav';
import EventActivityFeed from '../components/EventActivityFeed';
import AttendanceActivityFeed from '../components/AttendanceActivityFeed';
import PersonActivityFeed from '../components/PersonActivityFeed';
import { fetchGroup, addAlert } from '../actions';
import { client, dashboardPath } from '../utils';

class Dashboard extends Component {
  state = { events: { updated: [], created: [] }, attendances: {},
    people: { updated: [], created: [] }
  }

  componentWillMount() {
    const { groupId } = this.props.match.params;

    this.props.fetchGroup(groupId);

    client.get(`${dashboardPath()}.json`).then(response => {
      this.setState({ ...response.data })
    }).catch(alert => {
      this.props.addAlert(alert);
    });
  }

  render() {
    const { attributes } = this.props.group;
    const { events, attendances, people } = this.state;

    if(!attributes) { return null }

    return (
      <div>
        <Breadcrumbs active='Dashboard' location={this.props.location} />

        <br />

        <Nav activeTab='dashboard' />
        <br />
        <div dangerouslySetInnerHTML={{ __html: attributes.description }} />

        <br />
        <h2>Activity Feed</h2>
        <hr />
        <h3>Events</h3>
        <EventActivityFeed events={events.updated} type='Update'/>
        <br />
        <EventActivityFeed events={events.created} type='Create'/>

        <br />
        <h3>New Recorded Attendances</h3>
        <AttendanceActivityFeed attendances={attendances} />

        <br />
        <h3>People</h3>
        <PersonActivityFeed people={people.updated} type='Update'/>
        <br />
        <PersonActivityFeed people={people.created} type='Create'/>
      </div>
    );
  }
}

const mapStateToProps = ({ group }) => {
  return { group }
};

export default connect(mapStateToProps, { fetchGroup, addAlert })(Dashboard);
