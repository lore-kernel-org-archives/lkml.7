Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E9CC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 18:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820BD206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 18:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfHXSIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 14:08:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11560 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726390AbfHXSIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 14:08:53 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7OI6i1q029107;
        Sat, 24 Aug 2019 14:08:39 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uk1r8uana-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Aug 2019 14:08:39 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7OI8Y7A045088;
        Sat, 24 Aug 2019 14:08:38 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uk1r8uamy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Aug 2019 14:08:38 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7OI59ow014846;
        Sat, 24 Aug 2019 18:08:37 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04dal.us.ibm.com with ESMTP id 2ujvv63xjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Aug 2019 18:08:37 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7OI8af436700582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Aug 2019 18:08:36 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9076B2073;
        Sat, 24 Aug 2019 18:08:36 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6900B205F;
        Sat, 24 Aug 2019 18:08:36 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.187.121])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 24 Aug 2019 18:08:36 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CB3CD16C65C7; Sat, 24 Aug 2019 06:32:04 -0700 (PDT)
Date:   Sat, 24 Aug 2019 06:32:04 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, parri.andrea@gmail.com,
        byungchul.park@lge.com, peterz@infradead.org, mojha@codeaurora.org,
        ice_yangxiao@163.com, efremov@linux.com, edumazet@google.com
Subject: Re: [GIT PULL rcu/next + tools/memory-model] RCU and LKMM commits
 for 5.4
Message-ID: <20190824133204.GT28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190822151811.GA8894@linux.ibm.com>
 <20190822185429.GA110910@gmail.com>
 <20190822192132.GJ28441@linux.ibm.com>
 <20190824120102.GA10758@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190824120102.GA10758@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-24_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908240201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2019 at 02:01:02PM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> 
> > On Thu, Aug 22, 2019 at 08:54:29PM +0200, Ingo Molnar wrote:
> > 
> > [ . . . ]
> > 
> > > Pulled into tip:core/rcu, thanks a lot Paul!
> > 
> > Thank you!
> > 
> > > The merge commit is a bit non-standard:
> > > 
> > >   07f038a408fb: Merge LKMM and RCU commits
> > > 
> > > but clear enough IMHO. Usually we try to keep this format:
> > > 
> > >   6c06b66e957c: Merge branch 'X' into Y
> > > 
> > > even for internal merge commits.
> > 
> > Please accept my apologies!  How about as shown below?  If this works
> > for you, I will rebase my development commits on top this merge commit
> > in order to make sure I don't revert back to my old format for next
> > merge window.
> 
> Looks good - but I don't think we should create a new merge commit just 
> for this.

Ah, right -- I need to keep my development commits on top of the old
merge commit to enable the likely additional pull request that I
mentioned below.  Good point!  ;-)

							Thanx, Paul

> > Ah, speaking of reminding me...  There is likely to be one more small RCU
> > commit requested by the RISC-V guys.  If testing and review goes well,
> > I will send you a pull request for it by the middle of next week.
> 
> Thanks!
> 
> 	Ingo
