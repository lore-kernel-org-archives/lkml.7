Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C818C04AB1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 00:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D09A217D7
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 00:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfELAlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 20:41:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726447AbfELAlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 20:41:37 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4C0W7PN034725
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 20:41:36 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sdrq9rqpk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 20:41:36 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 12 May 2019 01:41:34 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 12 May 2019 01:41:32 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4C0fV3237028086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 May 2019 00:41:31 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72BB1B2065;
        Sun, 12 May 2019 00:41:31 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 516E8B205F;
        Sun, 12 May 2019 00:41:31 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.145.78])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 12 May 2019 00:41:31 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 03D3416C6B83; Sat, 11 May 2019 17:41:31 -0700 (PDT)
Date:   Sat, 11 May 2019 17:41:31 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
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
 <20190508181638.GY3923@linux.ibm.com>
 <20190511221126.GA3984@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190511221126.GA3984@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19051200-0040-0000-0000-000004EE6F7E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011087; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01202011; UDB=6.00630815; IPR=6.00982911;
 MB=3.00026851; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-12 00:41:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051200-0041-0000-0000-000008FA7B8C
Message-Id: <20190512004131.GE3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-11_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905120002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 12:11:26AM +0200, Andrea Parri wrote:
> Hi Paul, Joel,
> 
> > > > On the other hand, would you have ideas for more modern replacement
> > > > examples?
> > > 
> > > There are 3 cases I can see in listRCU.txt:
> > >   (1) action taken outside of read_lock (can tolerate stale data), no in-place update.
> > >                 this is the best possible usage of RCU.
> > >   (2) action taken outside of read_lock, in-place updates
> > >                 this is good as long as not too many in-place updates.
> > >                 involves copying creating new list node and replacing the
> > >                 node being updated with it.
> > >   (3) cannot tolerate stale data: here a deleted or obsolete flag can be used
> > >                                   protected by a per-entry lock. reader
> > > 				  aborts if object is stale.
> > > 
> > > Any replacement example must make satisfy (3) too?
> > 
> > It would be OK to have a separate example for (3).  It would of course
> > be nicer to have one example for all three, but not all -that- important.
> > 
> > > The only example for (3) that I know of is sysvipc sempahores which you also
> > > mentioned in the paper. Looking through this code, it hasn't changed
> > > conceptually and it could be a fit for an example (ipc_valid_object() checks
> > > for whether the object is stale).
> > 
> > That is indeed the classic canonical example.  ;-)
> > 
> > > The other example could be dentry look up which uses seqlocks for the
> > > RCU-walk case? But that could be too complex. This is also something I first
> > > learnt from the paper and then the excellent path-lookup.rst document in
> > > kernel sources.
> > 
> > This is a great example, but it would need serious simplification for
> > use in the Documentation/RCU directory.  Note that dcache uses it to
> > gain very limited and targeted consistency -- only a few types of updates
> > acquire the write-side of that seqlock.
> > 
> > Might be quite worthwhile to have a simplified example, though!
> > Perhaps a trivial hash table where write-side sequence lock is acquired
> > only when moving an element from one chain to another?
> 
> Sorry to take you down here..., but what do you mean by "the paper"?  ;-/

One or both of these two:

http://www2.rdrop.com/~paulmck/techreports/survey.2012.09.17a.pdf
http://www2.rdrop.com/~paulmck/techreports/RCUUsage.2013.02.24a.pdf

							Thanx, Paul

