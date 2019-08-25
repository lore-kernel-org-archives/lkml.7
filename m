Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ABDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 13:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B153E20850
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 13:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfHYNgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 09:36:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726686AbfHYNgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 09:36:18 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7PDVvQJ044656
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 09:36:17 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ukjjs4p0k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 09:36:16 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jwi@linux.ibm.com>;
        Sun, 25 Aug 2019 14:36:14 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 25 Aug 2019 14:36:12 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7PDaBKf27590724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Aug 2019 13:36:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0177E42041;
        Sun, 25 Aug 2019 13:36:11 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48B944203F;
        Sun, 25 Aug 2019 13:36:09 +0000 (GMT)
Received: from [9.145.165.177] (unknown [9.145.165.177])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 25 Aug 2019 13:36:09 +0000 (GMT)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_s390/ctcm=3a_Delete_unnecessary_checks_?=
 =?UTF-8?B?YmVmb3JlIHRoZSBtYWNybyBjYWxsIOKAnGRldl9rZnJlZV9za2LigJ0=?=
To:     Markus Elfring <Markus.Elfring@web.de>, linux-s390@vger.kernel.org,
        =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <84733436-46d1-8f43-780e-7b3ab9f2a0ae@web.de>
From:   Julian Wiedmann <jwi@linux.ibm.com>
Date:   Sun, 25 Aug 2019 21:36:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <84733436-46d1-8f43-780e-7b3ab9f2a0ae@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19082513-0008-0000-0000-0000030D2BED
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082513-0009-0000-0000-00004A2B6186
Message-Id: <9b655bf1-8565-d768-04ee-bc286a7e9efe@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-25_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908250153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.08.19 17:04, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 22 Aug 2019 10:55:33 +0200
> 
> The dev_kfree_skb() function performs also input parameter validation.
> Thus the test around the shown calls is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

Applied, thanks.

>  drivers/s390/net/ctcm_main.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
> index f63c5c871d3d..90025d1923d2 100644
> --- a/drivers/s390/net/ctcm_main.c
> +++ b/drivers/s390/net/ctcm_main.c
> @@ -1074,10 +1074,8 @@ static void ctcm_free_netdevice(struct net_device *dev)
>  		if (grp) {
>  			if (grp->fsm)
>  				kfree_fsm(grp->fsm);
> -			if (grp->xid_skb)
> -				dev_kfree_skb(grp->xid_skb);
> -			if (grp->rcvd_xid_skb)
> -				dev_kfree_skb(grp->rcvd_xid_skb);
> +			dev_kfree_skb(grp->xid_skb);
> +			dev_kfree_skb(grp->rcvd_xid_skb);
>  			tasklet_kill(&grp->mpc_tasklet2);
>  			kfree(grp);
>  			priv->mpcg = NULL;
> --
> 2.23.0
> 

