Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6E5C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C488020850
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfEHSQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 14:16:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726559AbfEHSQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 14:16:43 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x48ICKH2033611
        for <linux-kernel@vger.kernel.org>; Wed, 8 May 2019 14:16:41 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sc3vr0vb3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 14:16:41 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 8 May 2019 19:16:40 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 May 2019 19:16:38 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x48IGbn431719532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 May 2019 18:16:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E2B3B205F;
        Wed,  8 May 2019 18:16:37 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71029B2067;
        Wed,  8 May 2019 18:16:37 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 May 2019 18:16:37 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E6DC116C343E; Wed,  8 May 2019 11:16:38 -0700 (PDT)
Date:   Wed, 8 May 2019 11:16:38 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc/rcu: Correct field_count field naming in examples
Reply-To: paulmck@linux.ibm.com
References: <20190505020328.165839-1-joel@joelfernandes.org>
 <20190507000453.GB3923@linux.ibm.com>
 <20190508162635.GD187505@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508162635.GD187505@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19050818-2213-0000-0000-0000038AA190
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011072; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01200459; UDB=6.00629877; IPR=6.00981345;
 MB=3.00026796; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-08 18:16:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050818-2214-0000-0000-00005E5B2D6C
Message-Id: <20190508181638.GY3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-08_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905080111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 12:26:35PM -0400, Joel Fernandes wrote:
> On Mon, May 06, 2019 at 05:04:53PM -0700, Paul E. McKenney wrote:
> > On Sat, May 04, 2019 at 10:03:10PM -0400, Joel Fernandes (Google) wrote:
> > > I believe this field should be called field_count instead of file_count.
> > > Correct the doc with the same.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > But if we are going to update this, why not update it with the current
> > audit_filter_task(), audit_del_rule(), and audit_add_rule() code?
> > 
> > Hmmm...  One reason is that some of them have changed beyond recognition.
> 
> It seems to me that these 3 functions are just structured differently but is
> conceptually the same.
> 
> There is now an array of lists stored in audit_filter_list. Each list is a
> set of rules. Versus in the listRCU.txt, there is only one global.
> 
> The other difference is there is a mutex held &audit_filter_mutex
> audit_{add,del}_rule. Where as in listRCU, it says that is not needed since
> another mutex is already held.

Agreed.

> > And this example code predates v2.6.12.  ;-)
> > 
> > So good eyes, but I believe that this really does reflect the ancient
> > code...
> > 
> > On the other hand, would you have ideas for more modern replacement
> > examples?
> 
> There are 3 cases I can see in listRCU.txt:
>   (1) action taken outside of read_lock (can tolerate stale data), no in-place update.
>                 this is the best possible usage of RCU.
>   (2) action taken outside of read_lock, in-place updates
>                 this is good as long as not too many in-place updates.
>                 involves copying creating new list node and replacing the
>                 node being updated with it.
>   (3) cannot tolerate stale data: here a deleted or obsolete flag can be used
>                                   protected by a per-entry lock. reader
> 				  aborts if object is stale.
> 
> Any replacement example must make satisfy (3) too?

It would be OK to have a separate example for (3).  It would of course
be nicer to have one example for all three, but not all -that- important.

> The only example for (3) that I know of is sysvipc sempahores which you also
> mentioned in the paper. Looking through this code, it hasn't changed
> conceptually and it could be a fit for an example (ipc_valid_object() checks
> for whether the object is stale).

That is indeed the classic canonical example.  ;-)

> The other example could be dentry look up which uses seqlocks for the
> RCU-walk case? But that could be too complex. This is also something I first
> learnt from the paper and then the excellent path-lookup.rst document in
> kernel sources.

This is a great example, but it would need serious simplification for
use in the Documentation/RCU directory.  Note that dcache uses it to
gain very limited and targeted consistency -- only a few types of updates
acquire the write-side of that seqlock.

Might be quite worthwhile to have a simplified example, though!
Perhaps a trivial hash table where write-side sequence lock is acquired
only when moving an element from one chain to another?

> I will keep any eye out for other examples in the kernel code as well.

Very good!

							Thanx, Paul

> Let me know what you think, thanks!
> 
>  - Joel
> 
> 
> > > ---
> > >  Documentation/RCU/listRCU.txt | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/RCU/listRCU.txt b/Documentation/RCU/listRCU.txt
> > > index adb5a3782846..190e666fc359 100644
> > > --- a/Documentation/RCU/listRCU.txt
> > > +++ b/Documentation/RCU/listRCU.txt
> > > @@ -175,7 +175,7 @@ otherwise, the added fields would need to be filled in):
> > >  		list_for_each_entry(e, list, list) {
> > >  			if (!audit_compare_rule(rule, &e->rule)) {
> > >  				e->rule.action = newaction;
> > > -				e->rule.file_count = newfield_count;
> > > +				e->rule.field_count = newfield_count;
> > >  				write_unlock(&auditsc_lock);
> > >  				return 0;
> > >  			}
> > > @@ -204,7 +204,7 @@ RCU ("read-copy update") its name.  The RCU code is as follows:
> > >  					return -ENOMEM;
> > >  				audit_copy_rule(&ne->rule, &e->rule);
> > >  				ne->rule.action = newaction;
> > > -				ne->rule.file_count = newfield_count;
> > > +				ne->rule.field_count = newfield_count;
> > >  				list_replace_rcu(&e->list, &ne->list);
> > >  				call_rcu(&e->rcu, audit_free_rule);
> > >  				return 0;
> > > -- 
> > > 2.21.0.1020.gf2820cf01a-goog
> > > 
> > 
> 

