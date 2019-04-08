Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE13C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297FD20830
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfDHS3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:29:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728951AbfDHS3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:29:14 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x38INmSP123784
        for <linux-kernel@vger.kernel.org>; Mon, 8 Apr 2019 14:29:13 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rraj8awkb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 14:29:13 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 8 Apr 2019 19:29:12 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Apr 2019 19:29:09 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x38IT81R36110428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Apr 2019 18:29:08 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9612B2064;
        Mon,  8 Apr 2019 18:29:07 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBE9FB207A;
        Mon,  8 Apr 2019 18:29:07 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  8 Apr 2019 18:29:07 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0FF7316C0EB6; Mon,  8 Apr 2019 11:29:11 -0700 (PDT)
Date:   Mon, 8 Apr 2019 11:29:11 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, oleg@redhat.com, jannh@google.com,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] doc/rcuref: Document real world examples in kernel
Reply-To: paulmck@linux.ibm.com
References: <20190329140555.118463-1-joel@joelfernandes.org>
 <20190404201039.GL14111@linux.ibm.com>
 <20190406021705.GA6615@localhost>
 <20190408175213.GT14111@linux.ibm.com>
 <20190408180859.GA133872@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408180859.GA133872@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19040818-0052-0000-0000-000003A937AA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010891; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01186219; UDB=6.00621251; IPR=6.00966976;
 MB=3.00026346; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-08 18:29:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040818-0053-0000-0000-0000606D2D2A
Message-Id: <20190408182911.GV14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904080146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 02:08:59PM -0400, Joel Fernandes wrote:
> On Mon, Apr 08, 2019 at 10:52:13AM -0700, Paul E. McKenney wrote:
> > On Sat, Apr 06, 2019 at 02:17:05AM +0000, Joel Fernandes wrote:
> > > On Thu, Apr 04, 2019 at 01:10:39PM -0700, Paul E. McKenney wrote:
> > > > On Fri, Mar 29, 2019 at 10:05:55AM -0400, Joel Fernandes (Google) wrote:
> > > > > Document similar real world examples in the kernel corresponding to the
> > > > > second and third code snippets. Also correct an issue in
> > > > > release_referenced() in the code snippet example.
> > > > > 
> > > > > Cc: oleg@redhat.com
> > > > > Cc: jannh@google.com
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > 
> > > > Good catch, thank you!
> > > > 
> > > > As usual, I could not resist doing a bit of wordsmithing.  Please let me
> > > > know if I messed anything up in the version shown below.
> > > > 
> > > > 								Thanx, Paul
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > commit adcd92c0ab303b57b28a3cd097bd9ece824c14f6
> > > > Author: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > Date:   Fri Mar 29 10:05:55 2019 -0400
> > > > 
> > > >     doc/rcuref: Document real world examples in kernel
> > > >     
> > > >     Document similar real world examples in the kernel corresponding to the
> > > >     second and third code snippets. Also correct an issue in
> > > >     release_referenced() in the code snippet example.
> > > >     
> > > >     Cc: oleg@redhat.com
> > > >     Cc: jannh@google.com
> > > >     Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > >     [ paulmck: Do a bit of wordsmithing. ]
> > > >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > > > 
> > > > diff --git a/Documentation/RCU/rcuref.txt b/Documentation/RCU/rcuref.txt
> > > > index 613033ff2b9b..c0bab7fb57e7 100644
> > > > --- a/Documentation/RCU/rcuref.txt
> > > > +++ b/Documentation/RCU/rcuref.txt
> > > > @@ -12,6 +12,7 @@ please read on.
> > > >  Reference counting on elements of lists which are protected by traditional
> > > >  reader/writer spinlocks or semaphores are straightforward:
> > > >  
> > > > +CODE LISTING A:
> > > >  1.				2.
> > > >  add()				search_and_reference()
> > > >  {				{
> > > > @@ -28,7 +29,8 @@ add()				search_and_reference()
> > > >  release_referenced()			delete()
> > > >  {					{
> > > >      ...					    write_lock(&list_lock);
> > > > -    atomic_dec(&el->rc, relfunc)	    ...
> > > > +    if(atomic_dec_and_test(&el->rc))	    ...
> > > > +	kfree(el);
> > > >      ...					    remove_element
> > > >  }					    write_unlock(&list_lock);
> > > >   					    ...
> > > > @@ -44,6 +46,7 @@ search_and_reference() could potentially hold reference to an element which
> > > >  has already been deleted from the list/array.  Use atomic_inc_not_zero()
> > > >  in this scenario as follows:
> > > >  
> > > > +CODE LISTING B:
> > > >  1.					2.
> > > >  add()					search_and_reference()
> > > >  {					{
> > > > @@ -79,6 +82,7 @@ search_and_reference() code path.  In such cases, the
> > > >  atomic_dec_and_test() may be moved from delete() to el_free()
> > > >  as follows:
> > > >  
> > > > +CODE LISTING C:
> > > >  1.					2.
> > > >  add()					search_and_reference()
> > > >  {					{
> > > > @@ -114,6 +118,16 @@ element can therefore safely be freed.  This in turn guarantees that if
> > > >  any reader finds the element, that reader may safely acquire a reference
> > > >  without checking the value of the reference counter.
> > > >  
> > > > +A clear advantage of the RCU-based pattern in listing C over the one
> > > > +in listing B is that any call to search_and_reference() that locates
> > > > +a given object will succeed in obtaining a reference to that object,
> > > > +even given a concurrent invocation of delete() for that same object.
> > > 
> > > This part sounds good to me.
> > > 
> > > > +Similarly, a call to delete() is not delayed even if there are an
> > > > +arbitrarily large number of calls to search_and_reference() searching
> > > > +for the same object that delete() was invoked on.  Instead, all that is
> > > > +delayed is the eventual invocation of kfree(), which is usually not a
> > > > +problem on modern computer systems, even the small ones.
> > > > +
> > > 
> > > small nit:
> > > This part is common to both listing B and C right? The delete() is never
> > > delayed due to the search_and_reference in either case, and the kfree is what
> > > is delayed.  My patch was highlighting the difference between the 2
> > > listings, but this text says what is common between both listings.
> > > 
> > > As such I am Ok with the changes you made, and thanks for this document in
> > > the first place.
> > 
> > Good point!  How about the following patch to be merged into the current
> > patch?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/Documentation/RCU/rcuref.txt b/Documentation/RCU/rcuref.txt
> > index c0bab7fb57e7..5e6429d66c24 100644
> > --- a/Documentation/RCU/rcuref.txt
> > +++ b/Documentation/RCU/rcuref.txt
> > @@ -122,11 +122,12 @@ A clear advantage of the RCU-based pattern in listing C over the one
> >  in listing B is that any call to search_and_reference() that locates
> >  a given object will succeed in obtaining a reference to that object,
> >  even given a concurrent invocation of delete() for that same object.
> > -Similarly, a call to delete() is not delayed even if there are an
> > -arbitrarily large number of calls to search_and_reference() searching
> > -for the same object that delete() was invoked on.  Instead, all that is
> > -delayed is the eventual invocation of kfree(), which is usually not a
> > -problem on modern computer systems, even the small ones.
> > +Similarly, a clear advantage of both listings B and C over listing A is
> > +that a call to delete() is not delayed even if there are an arbitrarily
> > +large number of calls to search_and_reference() searching for the same
> > +object that delete() was invoked on.  Instead, all that is delayed is
> > +the eventual invocation of kfree(), which is usually not a problem on
> > +modern computer systems, even the small ones.
> >  
> >  In cases where delete() can sleep, synchronize_rcu() can be called from
> >  delete(), so that el_free() can be subsumed into delete as follows:
> 
> This one looks better to me, thanks a lot!
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thank you!  (Though this one gets merged into your original patch.)

							Thanx, Paul

