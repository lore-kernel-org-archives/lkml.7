Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2541C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29562086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfHEHZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 03:25:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20856 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbfHEHZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 03:25:32 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x757Ncsm128188
        for <linux-kernel@vger.kernel.org>; Mon, 5 Aug 2019 03:25:30 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u6e4kvsnx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 03:25:30 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jwi@linux.ibm.com>;
        Mon, 5 Aug 2019 08:25:28 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 5 Aug 2019 08:25:26 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x757PPrT37617832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Aug 2019 07:25:25 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0838D11C05B;
        Mon,  5 Aug 2019 07:25:25 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DCC611C052;
        Mon,  5 Aug 2019 07:25:24 +0000 (GMT)
Received: from [9.145.155.106] (unknown [9.145.155.106])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Aug 2019 07:25:24 +0000 (GMT)
Subject: Re: [PATCH] s390/net: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20190730001715.GA20706@embeddedor>
From:   Julian Wiedmann <jwi@linux.ibm.com>
Date:   Mon, 5 Aug 2019 09:25:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190730001715.GA20706@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19080507-0016-0000-0000-0000029A53FD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080507-0017-0000-0000-000032F95978
Message-Id: <9d2534f3-246b-ad01-6cae-b9c461b28bac@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-05_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908050084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.07.19 02:17, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings (Building: s390):
> 
> drivers/s390/net/ctcm_fsms.c: In function ‘ctcmpc_chx_attnbusy’:
> drivers/s390/net/ctcm_fsms.c:1703:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (grp->changed_side == 1) {
>       ^
> drivers/s390/net/ctcm_fsms.c:1707:2: note: here
>   case MPCG_STATE_XID0IOWAIX:
>   ^~~~
> 
> drivers/s390/net/ctcm_mpc.c: In function ‘ctc_mpc_alloc_channel’:
> drivers/s390/net/ctcm_mpc.c:358:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (callback)
>       ^
> drivers/s390/net/ctcm_mpc.c:360:2: note: here
>   case MPCG_STATE_XID0IOWAIT:
>   ^~~~
> 
> drivers/s390/net/ctcm_mpc.c: In function ‘mpc_action_timeout’:
> drivers/s390/net/ctcm_mpc.c:1469:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if ((fsm_getstate(rch->fsm) == CH_XID0_PENDING) &&
>       ^
> drivers/s390/net/ctcm_mpc.c:1472:2: note: here
>   default:
>   ^~~~~~~
> drivers/s390/net/ctcm_mpc.c: In function ‘mpc_send_qllc_discontact’:
> drivers/s390/net/ctcm_mpc.c:2087:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (grp->estconnfunc) {
>       ^
> drivers/s390/net/ctcm_mpc.c:2092:2: note: here
>   case MPCG_STATE_FLOWC:
>   ^~~~
> 
> drivers/s390/net/qeth_l2_main.c: In function ‘qeth_l2_process_inbound_buffer’:
> drivers/s390/net/qeth_l2_main.c:328:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     if (IS_OSN(card)) {
>        ^
> drivers/s390/net/qeth_l2_main.c:337:3: note: here
>    default:
>    ^~~~~~~
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/s390/net/ctcm_fsms.c    | 1 +
>  drivers/s390/net/ctcm_mpc.c     | 3 +++
>  drivers/s390/net/qeth_l2_main.c | 2 +-
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 

Applied, thanks.

