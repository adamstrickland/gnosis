# Gnosis

Have you ever used Confluence?  I mean, really tried to __use__ it?  I mean, a
lot of companies have it.  It can be configured in a million different ways, it
can store just about anything, and it integrates with AllTheThings.

And it's abysmal.

Authoring is a pain.  The WSIWYG is terrible.  Versioning is kludgy.
Collaborating?  Forget it.  Editing tools, what editing tools?  And, worst of
all: it's hard to find things.  It's like a wooly mammoth in modern-day Los
Angeles: big, clumsy, entirely unsuited to its environment, and surrounded by
tarpits and elevated freeways.

Gnosis is about simplicity.  It's based on 3 ideals:

- authoring should be easy, for both techies and luddites;
- finding information must be straightforward, quick, and accurate; and
- sane defaults save lives.

I think we can all agree on the first two principles.  The third may be somewhat
controversial, so...

> #### Sane Defaults Save Lives

> Look, we are all individuals.  Everyone - and every company - is a vessel unto
> themself.  But why, oh why, do we have this INSANE driver to "do the same shit
> our own way"?  Now, don't get me wrong... There is value in heterogeneity.  I am
> a firm believer in diversity of opinions, survival of the fittest,
> and all that jazz.  But come on, do we have to reinvent the wheel __every__ time
> we buy a new car?  So, let's save our brains some cycles to use on important
> things (think: solve world hunger, interstellar travel, and figuring out why we
> started to listen to Jenny McCarthy about ANYTHING.  But I digres...).

## Getting Started

At the moment, this is a standard Rails 3-step:

1. Clone the repo
2. Run `bundle install`
3. Run `bundle exec rails db:setup`

Out of the box the `DATABASE_URL` is set to use your local Postgres instance
(version 12.x or higher is required).  If you so desire, you can run a database
via Docker Compose (`docker-compose up`); you'll want to copy 
`.env.{development,test}.local.sample` to `.env.{development,test}.local`.

## Usage

There are 2 ways to do this, the Easy Way:tm: and the Hard Way:tm:

### The Easy Way:tm:

It's pretty simple: go to <https://gnos.is>, register your organization and
invite people via email.  You'll need a credit card for that register part, FYI.
So let's say your organization if "Foo Associates" (I know, not original: see
[above](#sane-defaults-save-lives)); you'll be assigned a subdomain,
<https://foo_associates.gnos.is>.  Under that there are 3 main entrypoints:
- [__/manage__](https://foo_associates.gnos.is/manage) - allows privileged users
  to manage the organization; you know, stuff like inviting people, etc.
- [__/content__](https://foo_associates.gnos.is/content) - a user interface to
  your content: stuff like dashboards, etc.
- [__/browse__](https://foo_associates.gnos.is/browse) - contains your org's
  files.  More on this below.

If you choose the Easy Way:tm:, you can delete this repository and go on your
merry way.  Enjoy!

### The Hard Way:tm:

Ugh.  Someone __always__ wants to go the hard way.  Whatever.

If you're not sure what these steps mean, you're in the wrong section (hint: go
[here](#the-easy-way)).  Have fun stormin' the castle!

1. Set up an S3 bucket. You'll probably also want an AWS IAM user for this
application.
2. Configure this application to be hosted somewhere; you'll need to provide the
following environment variables:
  - `GNOSIS_AWS_ACCESS_KEY_ID`
  - `GNOSIS_AWS_SECRET_ACCESS_KEY`
3. Provision a database; configure the app to use that database via the
`DATABASE_URL` environment variable.
4. Provision and configure an Auth0-compatible authz/authn solution. Configure
the app to use it via `TO_BE_DETERMINED`.
5. Provision an elasticsearch cluster.  Configure the app using
`ELASTICSEARCH_URL`.
6. Deploy the app.  There's a [Dockerfile](./Dockerfile); that'd be the
suggested mechanism, but do whatever you want.
7. Run `bundle exec rails gnosis:provision` and follow the prompts.
