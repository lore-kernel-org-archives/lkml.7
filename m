Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EF2C17460
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0BE21929
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qtVA+cdr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389697AbfKEOpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:45:42 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57992 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387584AbfKEOpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:45:42 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA5EhvXr189911;
        Tue, 5 Nov 2019 14:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=cnDpTqKYig+iH0LVqI9Gl2wReEqnuaD2T/o9SmZyNkk=;
 b=qtVA+cdrShb6jSyaz3UziS7FJjEn6W9l/Z7maw3KFMiehu/eftD9aUi6wV3ovSZ2Diae
 O8ho90M0Ir7Zjk4L/dmt7nFIZG3cgcIzP0fRgkNbsPjeIaJ1v+qECcvIDS+dtjJs6Fl5
 61DqipYaASuAa/wSdO0bBpadc2cRFyVAUl6waG8u5yw4QhVU5OqeZ6g1TThFQFgeckzK
 G+oYN6OoTehDayxfaUQqUvmR3Y0tFyvdeRSVDJPeHGLEcJSXwXXFPhJpUIVEPGsc0ZYm
 sTkqUPgCmLBCUI3cBaFSNHoOwdj1A1qOggUXz9dLeOiWo5+jlGod7sEtup9HGdX55ls/ fQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2w11rpxuyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Nov 2019 14:44:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA5EiIGJ040820;
        Tue, 5 Nov 2019 14:44:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2w3161e8jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Nov 2019 14:44:23 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA5Ehe9v011602;
        Tue, 5 Nov 2019 14:43:40 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Nov 2019 06:43:39 -0800
Date:   Tue, 5 Nov 2019 17:43:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        perex@perex.cz, gregkh@linuxfoundation.org,
        kstewart@linuxfoundation.org, allison@lohutok.net,
        tglx@linutronix.de, joe@perches.com
Subject: Re: [PATCH v2] hp100: remove set but not used variable val
Message-ID: <20191105144329.GG10409@kadam>
References: <20191105133554.6C01F9A06CB85816F399@huawei.com>
 <1572964619-76671-1-git-send-email-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572964619-76671-1-git-send-email-chenwandun@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=774
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911050123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=860 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911050123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 10:36:59PM +0800, Chen Wandun wrote:
> From: Chenwandun <chenwandun@huawei.com>
> 
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/staging/hp/hp100.c: In function hp100_start_xmit:
> drivers/staging/hp/hp100.c:1629:10: warning: variable val set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Chenwandun <chenwandun@huawei.com>
> ---

You should explain why you are sending a v2 under the --- cut off line.

The v1 was the correct patch, but this driver is going to be deleted
soon so I don't think we are accepting this sort of cleanup.

regards,
dan carpenter

