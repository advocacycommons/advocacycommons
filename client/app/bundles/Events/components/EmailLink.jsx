import React from 'react';

const EmailLink = ({ email, style }) => {
  if (email)
    return <a href={`mailto:${email}`} style={style} className='fa fa-envelope-o'/>
}

export default EmailLink;
