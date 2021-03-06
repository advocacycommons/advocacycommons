# Design Sketch for Networks for feature toggles

The current implementation of feature toggles is given in `./feature_toggles.rb`. Its main purpose is (currently) to disable a given feature for groups and their subgroups.

# Problems:

1. looking up groups by name is yucky, but with multiple servers and growing list of customers we cannot know the id of a group in advance

2. we don't really have a good way of enumerating all of the subgroups of a group (if we follow all the affiliation edges in an affiliation graph via BFS or DFS we would discover nodes that are not necessarily subgroups of the group we started with. If we did something less fancy we would either loop for ever or not discover all children.)


# Status:

* [x] **Implement`NetworkMembership`:**
* add `Network` model, which  must have a unique name
* groups can:
  * be member of a network (via a `NetworkMembership`)
  * have a primary network
  * not have more than one primary network
  * not become member of same network twice

* [x] **Modify `FeatureToggles::RULES`:**
  * enumerate the names of networks for which a given feature is to be disabled (relying on the strong guarantee that networks must have unique names) --> inject `RULES` for now
  * when calling `FeatureToggle.active?(:some_feather, group: some_group)`, inspect whether `some_group.primary_network.name` is included in the enumerated list of black listed network names to determine whether the toggle should be on or not

* [x] **Modify `create_subgroup`**
  * when called (eg from the public subgroup creation form): add the subgroup to the parent group's `Network` (by assigning it the same `network_id` that its parent had

* [x] **read networks from configs:**
  * Create a `networks.yml` config file that enumerates:*
    * keys that correspond to the names of the root group of a network (eg: `swing_left:`)
    * values that correspond to any attributes of the root group
  * populate `FeatureToggle::NETWORKS` from this config file
  * alt config file for tests?
  * maybe use configs to specify `FeatureToggle::RULES`

* [ ] **use feature toggle for events**
  * pass feature toggles to client via API calls (grr...)
  * update dev data so we can see this working in browser

* [ ] **Create an `update_networks` migration that:**
  * we run *every time** we add a root group
  * reads the attributes of all groups in `networks.yml`
  * uses `#find_or_create` to create new `Group` or `Network` instances that have been added to the `.yml file since the last migration
  * fun migration & verify that feature toggle works for events in dev env w/o using add-hoc data added in last step (ie: after db:reset)
