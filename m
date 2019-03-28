Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC04C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5AB206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DpF3NbO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfC1CHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 22:07:44 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58134 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1CHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 22:07:44 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2S1xTRO046009;
        Thu, 28 Mar 2019 02:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=q2xPT9aYNv3n8ZfbCyQkPK3lG0v/KfOw17OG2y43ouA=;
 b=DpF3NbO5A2nx3SxeLhTtppsbjc3d5tY0OL68fvo+YlwyxmJQ0hOZ5tpn7d72wgyzyZ+6
 U7iy2EREcMYvG3B1EWzo8fAsmrHI38sEVW1gNtxQR16eCaws9sqwptXeqX3lY0IhcSkD
 wEkUn5FBj97pAnu2GwEkvWdJ5Pj1uBgvOOf0dTQp66S87UFGcYFMFc+hUmayzmLaZTvi
 nnQj0U7HyLPZbdpsKKZLkb+M4YjF1Xa9MetTdZ2h9QBpxetsl3G6U0OFkE7CKfkJSGp1
 OrbSx+cK5ZmfXsmIPMA2/ifOOTN5DIB3m87xnaduzd4RA4lK9WA5taTHJ6+QfdgAK5i/ /g== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2re6g13wke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 02:07:28 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2S27QcZ016528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 02:07:26 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2S27NBM010391;
        Thu, 28 Mar 2019 02:07:23 GMT
Received: from kadam (/197.157.34.194)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Mar 2019 19:07:22 -0700
Date:   Thu, 28 Mar 2019 05:07:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Anirudh Rayabharam <anirudh.rayabharam@gmail.com>
Cc:     gregkh@linuxfoundation.org, hadess@hadess.net, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: core: fix line over 80 characters
 warning
Message-ID: <20190328020714.GF32590@kadam>
References: <20190326182309.GA33380@auvm>
 <20190327181836.GA37876@auvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327181836.GA37876@auvm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9208 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903280014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

