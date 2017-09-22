class Plotter {

  PhysicsEngine engine;
  PImage paused;
  PImage logo;
  PImage gameover;

  public Plotter( PhysicsEngine engine ) {
    this.engine = engine;
    paused = loadImage("./assets/paused.png");
    logo = loadImage("./assets/game1.png");
    gameover = loadImage("./assets/gameover.png");
  }

  public void clearScreen() {
    /*fill(255);
     stroke(255);
     quad(0,0,0,width,height,width,height,0);*/
    clear();
    background(255);
    if ( engine.hit() ) {
      background(#FF4A4A);
    }
  }

  public void plotCursor() {
    stroke(0);
    line(mouseX - 10, mouseY, mouseX + 10, mouseY);
    line(mouseX, mouseY - 10, mouseX, mouseY + 10);
  }

  public void plotHUD() {
    fill(0);
    stroke(0);
    int hp = (engine.player == null)?0:engine.player.hp;
    //text("hp "+hp+"/10",10,20);
    stroke(0);

    //hp
    int hpcolor;
    if ( hp <= 8 && hp > 5 ) {
      hpcolor = #FF7003;
    } else
      if ( hp <= 5) {
        hpcolor = #FF0000;
      } else {
        hpcolor = #00F501;
      }
    fill(hpcolor);
    rect(10, 0, hp*5, 10);  

    stroke(0);
    fill(0);
    rect(10+(5*hp), 0, (20-hp)*5, 10);

    //bullets

    fill(#0000FF);
    stroke(0);
    if ( engine.player != null)
      for ( int i = 0; i < (5-engine.player.projs); i++) {
        rect(10+(10*i), 12, 5, 10);
      }

    //score

    fill(0);
    text("score: "+engine.score, 10, 32);
  }

  public void plotEntities() {
    for ( Entity e : engine.entities ) {
      plotEntity(e);
    }
  }

  public void plotEntity( Entity e ) {
    if ( e instanceof Enemy) {

      if ( e instanceof EnemyTank) {
        fill(#939393);
        stroke(0);
        Vector p1 = new Vector(0, 14.5);
        p1.rotate(45);
        Vector p2 = p1.cpy();
        p2.rotate(90);
        Vector p3 = p2.cpy();
        p3.rotate(90);
        Vector p4 = p3.cpy();
        p4.rotate(90);

        p1.add(e.pos);
        p2.add(e.pos);
        p3.add(e.pos);
        p4.add(e.pos);

        quad(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x, p4.y);
        fill(0);
        text(e.hp, e.pos.x, e.pos.y);
      } else if ( e instanceof EnemySpeed ) {
        fill(#FFF700);
        stroke(0);
        Vector dir = p.pos.staticSub(e.pos);
        dir.normalize(15);
        Vector p1 = dir.cpy();
        p1.rotate(120);
        Vector p2 = p1.cpy();
        p2.rotate(120);

        dir.add(e.pos);
        p1.add(e.pos);
        p2.add(e.pos);

        triangle(dir.x, dir.y, p1.x, p1.y, p2.x, p2.y);
      } else if (e instanceof EnemySin) {
        fill(#00FFA3);
        stroke(0);
        ellipse(e.pos.x, e.pos.y, 10, 10);
      } else if ( e instanceof EnemyPlanet ) {
        //big circle
        fill(#03FF11);
        stroke(0);
        ellipse(e.pos.x, e.pos.y, 25, 25);
        fill(0);
        text(e.hp, e.pos.x, e.pos.y);
      } else if ( e instanceof EnemySatellite ) {
        //small circle
        switch((int)e.hp) {
        case 1:
          fill(#EEEEEE);
          break;
        case 2:
          fill(#DDDDDD);
          break;
        case 3:
          fill(#CCCCCC);
          break;
        case 4:
          fill(#BBBBBB);
          break;
        case 5:
          fill(#AAAAAA);
          break;
        }
        stroke(0);
        ellipse(e.pos.x, e.pos.y, 15, 15);
      } else if ( e instanceof BossCluster) {
        fill(#0B6700);
        stroke(0);
        pushMatrix();
        translate(e.pos.x, e.pos.y);
        rotate(radians(((BossCluster)e).frames));
        polygon(0, 0, 25, 5);
        popMatrix();
      } else if ( e instanceof EnemyCluster) {
        fill(#0FD80D);
        stroke(0);
        pushMatrix();
        translate(e.pos.x, e.pos.y);
        rotate(radians(((EnemyCluster)e).frames));
        polygon(0, 0, 15, 5);
        popMatrix();
      } else if ( e instanceof Cluster  ) {
        fill(#97FF95);
        stroke(0);
        pushMatrix();
        translate(e.pos.x, e.pos.y);
        rotate(radians(((Cluster)e).frames));
        polygon(0, 0, 7, 5);
        popMatrix();
      } else if ( e instanceof EnemyShark ) {
        //colorMode(HSB,1,1,1);
        fill(#003CDE);
        stroke(0);
        //colorMode(RGB);

        Vector dir = e.vel.cpy();
        //dir.rotate(180);
        dir.normalize(15);
        Vector p1 = dir.cpy();
        p1.rotate(120);
        Vector p2 = p1.cpy();
        p2.rotate(120);

        dir.add(e.pos);
        p1.add(e.pos);
        p2.add(e.pos);

        beginShape();
        vertex(dir.x, dir.y);
        vertex(p2.x, p2.y);
        vertex(e.pos.x, e.pos.y);
        vertex(p1.x, p1.y);
        endShape(CLOSE);
      } else if ( e instanceof Zoid ) {
        fill(#FF0000);
        stroke(0);
        ellipse(e.pos.x, e.pos.y, 20, 20);
        Zoid aux = ((Zoid)e).next;
        fill(#FFFF00);
        if ( aux != null) {
          while ( aux.next != null ) {
            ellipse(aux.pos.x, aux.pos.y, 20, 20);
            aux = aux.next;
          }
          ellipse(aux.pos.x, aux.pos.y, 20, 20);
        }
      } else if ( e instanceof SnipeBoss || e instanceof GigaSnipe ) {
        fill(#000000);
        stroke(0);
        
        //PVector k = new PVector(0,1);
        
        pushMatrix();
        translate(e.pos.x,e.pos.y);
        //rotate(PVector.angleBetween(((Snipe)e).calculateProjDir().toPVector(),k));
        polygon(0,0,15,9);
        popMatrix();
        fill(#ff0000);
        ellipse(e.pos.x, e.pos.y, 28, 28);
        fill(#777777);
        Vector dir = ((Snipe)e).calculateProjDir();
        Vector p1 = ((Snipe)e).calculateProjDir();
        p1.normalize(20);
        p1.rotate(22.5);
        Vector p2 = p1.cpy();
        p2.rotate(135);
        Vector p3 = p2.cpy();
        p3.rotate(45);
        Vector p4= p3.cpy();
        p4.rotate(135);
        /*
        dir.normalize(10);
        //*/
        p1.add(dir);
        p2.add(dir);
        p3.add(dir);
        p4.add(dir);
        //*/
        p1.add(e.pos);
        p2.add(e.pos);
        p3.add(e.pos);
        p4.add(e.pos);
        
        quad(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y,p4.x,p4.y);
      }else if ( e instanceof SnipeMinion) {
        fill(#000000);
        stroke(0);
        
        //PVector k = new PVector(0,1);
        
        pushMatrix();
        translate(e.pos.x,e.pos.y);
        //rotate(PVector.angleBetween(((Snipe)e).calculateProjDir().toPVector(),k));
        polygon(0,0,13,9);
        popMatrix();
        fill(#ffff00);
        ellipse(e.pos.x, e.pos.y, 24, 24);
        fill(#777777);
        Vector dir = ((Snipe)e).calculateProjDir();
        Vector p1 = ((Snipe)e).calculateProjDir();
        p1.normalize(14);
        p1.rotate(22.5);
        Vector p2 = p1.cpy();
        p2.rotate(135);
        Vector p3 = p2.cpy();
        p3.rotate(45);
        Vector p4= p3.cpy();
        p4.rotate(135);
        /*
        dir.normalize(10);
        //*/
        p1.add(dir);
        p2.add(dir);
        p3.add(dir);
        p4.add(dir);
        //*/
        p1.add(e.pos);
        p2.add(e.pos);
        p3.add(e.pos);
        p4.add(e.pos);
        
        quad(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y,p4.x,p4.y);
      } else if ( e instanceof EnemyProjectile) {
        fill(#810707);
        stroke(#000000);
        ellipse(e.pos.x, e.pos.y, 10, 10);
      } else {
        fill(#FF0000);
        stroke(0);

        Vector p1 = new Vector(0, 10.5);
        p1.rotate(45);
        Vector p2 = p1.cpy();
        p2.rotate(90);
        Vector p3 = p2.cpy();
        p3.rotate(90);
        Vector p4 = p3.cpy();
        p4.rotate(90);

        p1.add(e.pos);
        p2.add(e.pos);
        p3.add(e.pos);
        p4.add(e.pos);

        quad(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x, p4.y);

        //rect(e.pos.x, e.pos.y, 15, 15 );
        //polygon(e.pos.x,e.pos.y,5,4);
      }
      //drawCollider(e.collider);
    }
    if ( e instanceof Player) {
      Vector pos = e.pos.cpy();
      int size = 10;
      fill(#00FF00);
      stroke(0);

      Vector dir = ((Player)e).calculateProjDir();
      dir.normalize(size*1.5);

      Vector p1 = dir.cpy();
      p1.rotate(45);
      Vector p2 = p1.cpy();
      p2.rotate(90);
      Vector p3 = p2.cpy();
      p3.rotate(90);
      Vector p4 = p3.cpy();
      p4.rotate(90);    

      p1.add(pos);
      p2.add(pos);
      p3.add(pos);
      p4.add(pos);

      quad(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x, p4.y);
      //quad( pos.x - size , pos.y - size , pos.x - size , pos.y + size , pos.x + size , pos.y + size , pos.x + size , pos.y - size );
      //drawCollider(e.collider);
    }
    if ( e instanceof Projectile) {
      //drawCollider(e.collider);
      fill(#0000FF);
      stroke(#000000);
      ellipse(e.pos.x, e.pos.y, 10, 10);
    }
    drawCollider(e.collider);
  }


  public void polygon(float x, float y, float radius, int npoints) {
    float angle = TWO_PI / npoints;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius;
      float sy = y + sin(a) * radius;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }

  public void drawCollider( Collider c ) {
    //fill(255);
    noFill();
    stroke(#F436FF);
    Vector pos = c.getCenter().cpy();
    ellipse(pos.x, pos.y, c.radius*2, c.radius*2);
  }
  
  public void plotGame() {
    clearScreen();
    plotEntities();
    plotCursor();
    plotHUD();
  }
  
  public void plotGameover(){
    clearScreen();
    plotGameoverText();
    plotGameoverItems();
    plotCursor();
  }
  
  public void plotGameoverText(){}
  public void plotGameoverItems(){}
  
  public void plotMenu(){
    clearScreen();
    plotMenuItems();
    plotCursor();
  }
  
  public void plotMenuItems(){}
  
  public void plotPause(){
    clearScreen();
    plotEntities();
    plotCursor();
    plotPaused();
  }
  
  public void plotPaused(){
    //PRINT BIG PAUSED IMAGE
    image(this.paused,(width/2)-(this.paused.width/2),height/2);
  }
}