Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7110FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5345D233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404081AbfHVTVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 15:21:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59344 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731916AbfHVTVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:21:45 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7MJF9XY045451;
        Thu, 22 Aug 2019 15:21:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uhxpk62g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Aug 2019 15:21:34 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7MJG2vA050160;
        Thu, 22 Aug 2019 15:21:33 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uhxpk62f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Aug 2019 15:21:33 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7MJFtQa019589;
        Thu, 22 Aug 2019 19:21:32 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 2ufye0k76t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Aug 2019 19:21:32 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7MJLVUb48234924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 19:21:32 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1598B2065;
        Thu, 22 Aug 2019 19:21:31 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C084DB2064;
        Thu, 22 Aug 2019 19:21:31 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 22 Aug 2019 19:21:31 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id EBA5816C3888; Thu, 22 Aug 2019 12:21:32 -0700 (PDT)
Date:   Thu, 22 Aug 2019 12:21:32 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, parri.andrea@gmail.com,
        byungchul.park@lge.com, peterz@infradead.org, mojha@codeaurora.org,
        ice_yangxiao@163.com, efremov@linux.com, edumazet@google.com
Subject: Re: [GIT PULL rcu/next + tools/memory-model] RCU and LKMM commits
 for 5.4
Message-ID: <20190822192132.GJ28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190822151811.GA8894@linux.ibm.com>
 <20190822185429.GA110910@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822185429.GA110910@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-22_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908220165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 08:54:29PM +0200, Ingo Molnar wrote:

[ . . . ]

> Pulled into tip:core/rcu, thanks a lot Paul!

Thank you!

> The merge commit is a bit non-standard:
> 
>   07f038a408fb: Merge LKMM and RCU commits
> 
> but clear enough IMHO. Usually we try to keep this format:
> 
>   6c06b66e957c: Merge branch 'X' into Y
> 
> even for internal merge commits.

Please accept my apologies!  How about as shown below?  If this works
for you, I will rebase my development commits on top this merge commit
in order to make sure I don't revert back to my old format for next
merge window.

Ah, speaking of reminding me...  There is likely to be one more small RCU
commit requested by the RISC-V guys.  If testing and review goes well,
I will send you a pull request for it by the middle of next week.

							Thanx, Paul

------------------------------------------------------------------------

commit 864866f469d90bb7044a7e47b0168a2c143de4d4
Merge: cfcdef5e3046 6738ff85c3ee
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Thu Aug 22 12:09:20 2019 -0700

    Merge branch 'lkmm.2019.08.09a' into HEAD
    
    lkmm.2019.08.09a: Linux-kernel memory-model updates.

