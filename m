Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF0CC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9235820857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfDHCaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 22:30:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37030 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726412AbfDHCaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 22:30:21 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x382TDEU138324
        for <linux-kernel@vger.kernel.org>; Sun, 7 Apr 2019 22:30:20 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rqtexxk5y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 22:30:20 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 8 Apr 2019 03:30:19 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Apr 2019 03:30:15 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x382UEdf19464312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Apr 2019 02:30:14 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E125B2064;
        Mon,  8 Apr 2019 02:30:14 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C115B205F;
        Mon,  8 Apr 2019 02:30:14 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.136.16])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  8 Apr 2019 02:30:14 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CE65516C36AE; Sun,  7 Apr 2019 19:30:15 -0700 (PDT)
Date:   Sun, 7 Apr 2019 19:30:15 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        kernel-team@android.com, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] srcu: Remove unused vmlinux srcu linker entries
Reply-To: paulmck@linux.ibm.com
References: <20190408004719.178484-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408004719.178484-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19040802-2213-0000-0000-000003733292
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010887; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01185902; UDB=6.00621059; IPR=6.00966657;
 MB=3.00026334; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-08 02:30:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040802-2214-0000-0000-00005DF14ECB
Message-Id: <20190408023015.GH14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904080021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2019 at 08:47:19PM -0400, Joel Fernandes (Google) wrote:
> The SRCU for modules optimization (commit title "srcu: Allocate per-CPU
> data for DEFINE_SRCU() in modules") introduced vmlinux linker entries
> which is unused since it applies only to the built-in vmlinux. So remove
> it to prevent any space usage due to the 8 byte alignment it added.
> vmlinux.lds.h has no effect on module loading and is not used for
> building the module object, so the changes were not needed in the first
> place since the optimization is specific to modules.
> 
> Tested with SRCU torture_type and rcutorture. Put prints in module
> loader to confirm it is able to find and initialize the srcu structures.
> 
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: kernel-team@android.com
> Cc: paulmck@linux.vnet.ibm.com
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Queued, thank you, Joel!

							Thanx, Paul

> ---
> v1->v2: Added more context to change log.
> 
>  include/asm-generic/vmlinux.lds.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index c2d919a1566e..f8f6f04c4453 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -338,10 +338,6 @@
>  		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
>  		__stop___tracepoints_ptrs = .;				\
>  		*(__tracepoints_strings)/* Tracepoints: strings */	\
> -		. = ALIGN(8);						\
> -		__start___srcu_struct = .;				\
> -		*(___srcu_struct_ptrs)					\
> -		__end___srcu_struct = .;				\
>  	}								\
>  									\
>  	.rodata1          : AT(ADDR(.rodata1) - LOAD_OFFSET) {		\
> -- 
> 2.21.0.392.gf8f6787159e-goog
> 

