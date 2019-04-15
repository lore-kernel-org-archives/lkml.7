Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1D8C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931C720833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfDONd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:33:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727186AbfDONd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:33:58 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3FDTx3G029967
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 09:33:57 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rvtrx0h1w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 09:33:56 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 15 Apr 2019 14:33:55 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Apr 2019 14:33:49 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3FDXmHM16056362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 13:33:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B27B6B2066;
        Mon, 15 Apr 2019 13:33:48 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9424CB205F;
        Mon, 15 Apr 2019 13:33:48 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 15 Apr 2019 13:33:48 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 429D116C265F; Mon, 15 Apr 2019 06:33:52 -0700 (PDT)
Date:   Mon, 15 Apr 2019 06:33:52 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, srinivas.eeda@oracle.com
Subject: Re: [PATCH 1/2] doc: Fixup definition of
 rcupdate.rcu_task_stall_timeout
Reply-To: paulmck@linux.ibm.com
References: <1555211464-28652-1-git-send-email-zhenzhong.duan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555211464-28652-1-git-send-email-zhenzhong.duan@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19041513-0072-0000-0000-0000041A171C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010932; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01189443; UDB=6.00623207; IPR=6.00970229;
 MB=3.00026451; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-15 13:33:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041513-0073-0000-0000-00004BD5C834
Message-Id: <20190415133352.GT14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904150093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 11:11:03AM +0800, Zhenzhong Duan wrote:
> A positive value of rcupdate.rcu_task_stall_timeout is an interval
> in seconds rather than jiffies.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>

Good catch, applied, thank you!

Your other patch I must leave to others.

							Thanx, Paul

> ---
>  Documentation/RCU/stallwarn.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/RCU/stallwarn.txt b/Documentation/RCU/stallwarn.txt
> index 1ab70c3..13e88fc 100644
> --- a/Documentation/RCU/stallwarn.txt
> +++ b/Documentation/RCU/stallwarn.txt
> @@ -153,7 +153,7 @@ rcupdate.rcu_task_stall_timeout
>  	This boot/sysfs parameter controls the RCU-tasks stall warning
>  	interval.  A value of zero or less suppresses RCU-tasks stall
>  	warnings.  A positive value sets the stall-warning interval
> -	in jiffies.  An RCU-tasks stall warning starts with the line:
> +	in seconds.  An RCU-tasks stall warning starts with the line:
>  
>  		INFO: rcu_tasks detected stalls on tasks:
>  
> -- 
> 1.8.3.1
> 

