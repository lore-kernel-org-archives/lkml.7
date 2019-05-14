Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC3CC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468D220881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfENWNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 18:13:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbfENWNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 18:13:39 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4EMBx6G067910
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 18:13:38 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sg2rrghav-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 18:13:38 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 14 May 2019 23:13:37 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 May 2019 23:13:33 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4EMDWRU17367060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 22:13:32 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D13A0B2073;
        Tue, 14 May 2019 22:13:32 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD154B2071;
        Tue, 14 May 2019 22:13:32 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 14 May 2019 22:13:32 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 724DF16C3449; Tue, 14 May 2019 15:13:32 -0700 (PDT)
Date:   Tue, 14 May 2019 15:13:32 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc/rcu: Correct field_count field naming in examples
Reply-To: paulmck@linux.ibm.com
References: <20190505020328.165839-1-joel@joelfernandes.org>
 <20190507000453.GB3923@linux.ibm.com>
 <20190508162635.GD187505@google.com>
 <20190508181638.GY3923@linux.ibm.com>
 <20190513034305.GB96252@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513034305.GB96252@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19051422-0072-0000-0000-0000042D0016
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011098; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01203379; UDB=6.00631649; IPR=6.00984301;
 MB=3.00026893; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-14 22:13:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051422-0073-0000-0000-00004C390055
Message-Id: <20190514221332.GC4184@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905140146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 11:43:05PM -0400, Joel Fernandes wrote:
> On Wed, May 08, 2019 at 11:16:38AM -0700, Paul E. McKenney wrote:
> [snip]
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
> Here you meant "moving from one chain to another" in the case of
> hashtable-resizing right? I could not think of another reason why an element
> is moved between 2 hash chains.

Either that or in terms of atomic rekeying of a specific element in that
table, thus potentially requiring an atomic move of only that specific
element to another hash chain.

> I just finished reading the main parts of Josh's relativistic hashtable paper
> [1] and it is very cool indeed. The whole wait-for-readers application for
> hashtable expansion is so well thought. I am planning to go over more papers
> and code and can certainly update this example with a read-mostly hashtable
> example as well as you are suggesting. :-)
> 
> [1] https://www.usenix.org/legacy/event/atc11/tech/final_files/Triplett.pdf

Sounds very good!

							Thanx, Paul

