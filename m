Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BE2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38F7218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rB2Bb6DL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfDXOXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:23:17 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52424 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfDXOXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:23:17 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3OEJ0UN063607;
        Wed, 24 Apr 2019 14:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=XPXSty4w7Wc4EobjrLPS91gpcP7tZLOQKaDzDjYzwdU=;
 b=rB2Bb6DLvvUl56b46OSx4GJz6Z6BZvq+Zk4K/rWnHGecb0FBhAWos3Jsz+CsmDhgFyLV
 jRKxDwL+hNeOOFvCtXr1FxCImxPShk/lxB/DaZw9ieASSptp6LR1DpB44NNNmrCilPJN
 bN283yxo8/uyvBldNL3M3AdY7rIbLecscekNKGDc4/Wgc9OBSpiuSYhHmUfKAcrOlLMh
 JkldnrHuCSCzR+A53/iPzJPMpGVkMTDaXhd/vWqSz+ByRpLOMk2U9n/fw/lf9NMxB/d5
 J+KWiYHzeheEQ65W7SDRtc42wHe9vCc0w5XhJ/wkWsHGA/DuJ88xZS+UENpn1QWZHCZk hA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2ryrxd2w53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 14:23:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3OEMQPo008548;
        Wed, 24 Apr 2019 14:23:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2s0f0w41fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 14:23:08 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3OEN6PZ019190;
        Wed, 24 Apr 2019 14:23:07 GMT
Received: from kadam (/196.111.187.26)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Apr 2019 07:23:05 -0700
Date:   Wed, 24 Apr 2019 17:22:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     MosesChristopher <moseschristopherb@gmail.com>
Cc:     david.kershner@unisys.com, gregkh@linuxfoundation.org,
        sparmaintainer@unisys.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: unisys: use help instead of ---help--- in
 Kconfig
Message-ID: <20190424142248.GC14798@kadam>
References: <20190420114646.28817-1-moseschristopherb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420114646.28817-1-moseschristopherb@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9236 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=822
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904240112
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9236 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=848 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904240112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 11:46:46AM +0000, MosesChristopher wrote:
> From: Moses Christopher <moseschristopherb@gmail.com>
> 

Could you Fix your email From header so this isn't required?

regards,
dan carpenter

