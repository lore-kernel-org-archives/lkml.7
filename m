Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5215AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7B820693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732807AbfG3QCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:02:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730455AbfG3QCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:02:30 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6UFvYAr018983
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 12:02:29 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u2pev6mv9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 12:02:26 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 30 Jul 2019 17:02:24 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 30 Jul 2019 17:02:21 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6UG2KRU54329736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 16:02:21 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E531BB2066;
        Tue, 30 Jul 2019 16:02:20 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C51D5B2065;
        Tue, 30 Jul 2019 16:02:20 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.181.16])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Jul 2019 16:02:20 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6A3BC16C1708; Tue, 30 Jul 2019 09:02:21 -0700 (PDT)
Date:   Tue, 30 Jul 2019 09:02:21 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix spelling mistake "greate"->"great"
Reply-To: paulmck@linux.ibm.com
References: <1564386957-22833-1-git-send-email-mojha@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564386957-22833-1-git-send-email-mojha@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19073016-0064-0000-0000-000004047DCC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011523; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01239657; UDB=6.00653639; IPR=6.01021069;
 MB=3.00027960; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-30 16:02:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19073016-0065-0000-0000-00003E79E43D
Message-Id: <20190730160221.GX14271@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907300165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 01:25:57PM +0530, Mukesh Ojha wrote:
> There is a spelling mistake in file tree_exp.h,
> fix this.
> 
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>

Queued, thank you very much!

							Thanx, Paul

> ---
>  kernel/rcu/tree_exp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index af7e7b9..609fc87 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -781,7 +781,7 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
>   * other hand, if the CPU is not in an RCU read-side critical section,
>   * the IPI handler reports the quiescent state immediately.
>   *
> - * Although this is a greate improvement over previous expedited
> + * Although this is a great improvement over previous expedited
>   * implementations, it is still unfriendly to real-time workloads, so is
>   * thus not recommended for any sort of common-case code.  In fact, if
>   * you are using synchronize_rcu_expedited() in a loop, please restructure
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
> Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
> 

