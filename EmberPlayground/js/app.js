App = Ember.Application.create();

App.Router.map(function(){
    this.resource('about');
    this.resource('posts', function(){
        this.resource('post', { path: ':post_id' });
    });
});

App.PostsRoute = Ember.Route.extend({
  model: function () {
      return posts;
  }
});

App.PostRoute = Ember.Route.extend({
  model: function (params) {
      return posts.findBy('id', params.post_id);
  }
});

App.PostController = Ember.ObjectController.extend({
    isEditing: false,

    actions: {
        edit: function(){
            this.set('isEditing', true);
        },

        doneEditing: function() {
            this.set('isEditing', false);
        }
    }
});
Ember.Handlebars.helper('format-date-from-now', function(date){
    return moment(date).fromNow();
});

Ember.Handlebars.helper('long-format-date', function(date){
    return moment(date).format('MMMM Do YYYY');
});

var posts = [
    {
        id: '1',
        title: "Waking The Dead",
        author: {
            name: 'Jenner'
        },
        date: new Date('6-28-2010'),
        excerpt: "In order to reanimate the human body certain cells must be reactivated. The side-effect of doing this is that people often",
        body: "Book about bringing people back to life"
    },
    {
        id: '2',
        title: "Being a Good Cop",
        author: {
            name: 'Grimes'
        },
        date: new Date('4-28-2010'),
        excerpt: "you put your life on the line everyday for people, in the end all you can do is go home and hug your loved ones because you",
        body: "The life of police work"
    },
    {
        id: '3',
        title: "My Buddy's Wife",
        author: {
            name: 'Walsh'
        },
        date: new Date('2-3-2010'),
        excerpt: "and he doesn't appreciate her the best thing you can hope for is Armageddon 'cause thats what'll take for her to notice you",
        body: "Fiction yeah that's it it's just fiction"
    }
];