Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE4EFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DB12168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gW2jvxqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404843AbfJPOzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:55:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47238 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfJPOzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:55:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9GElKxc124421;
        Wed, 16 Oct 2019 14:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=r44O34qzc0k+ZTr+o+pUijPkcyNeplDRN6mlyThNKVk=;
 b=gW2jvxqheJFSkpJbARyXyrxAYhwam+IiUHrBI7xDdX3mqpAyXrVaL07mJLXBog92q36K
 hcMKXJVeWZbeSshxVzb8ZGeWb16w595Q+aitLnyIdiOyIXkYHFxdprtnn86iWpDSaWkG
 jvBafqQ+mfPqUDcg9BohYEmetrmmQqyWg+ftVj9NtZSpPH6Vov4BRq7tyfRgpsa2NUQo
 vsoJvBleBKrttZq5IPjW1KRXPPkarOsgVFE9CFfihBIBFk9xSJIJf7xmkzs6kQa4ftm9
 wWU6K4bwQE2YDYR9nGW0Wp+dtU2BhODq+wp3F2gNyzFW+0fZKfFCEqpE7k5SfsYfevsR +g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vk6sqqjs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 14:54:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9GEmnaj194932;
        Wed, 16 Oct 2019 14:54:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2vnf7thbn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 14:54:53 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9GEsi97027860;
        Wed, 16 Oct 2019 14:54:45 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Oct 2019 14:54:40 +0000
Date:   Wed, 16 Oct 2019 17:54:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chandra Annamaneni <chandra627@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        gneukum1@gmail.com, michael.scheiderer@fau.de,
        fabian.krueger@fau.de, linux-kernel@vger.kernel.org,
        simon@nikanor.nu
Subject: Re: [PATCH 2/4] staging: KPC2000: kpc2000_spi.c: Fix style issues
 (alignment)
Message-ID: <20191016145354.GB24678@kadam>
References: <20191016074927.20056-1-chandra627@gmail.com>
 <20191016074927.20056-2-chandra627@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016074927.20056-2-chandra627@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910160129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910160129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 12:49:25AM -0700, Chandra Annamaneni wrote:
> Resolved: "CHECK: Alignment should match open parenthesis" from checkpatch
> 

I think you accidentally copied the wrong commit message.  This one
and the next are the same.  This description doesn't match the patch.

regards,
dan carpenter

