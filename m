Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4347CC2D0D3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 18:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1702F2063A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 18:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="il8wPESI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfLUSpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 13:45:20 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36088 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfLUSpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 13:45:19 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBLIj2lJ080577;
        Sat, 21 Dec 2019 18:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=DOaak8punvqKDEKEpw641d8QYPKm92fSr8hBvOTIyBw=;
 b=il8wPESIsWwngVDgYbKOGibMN08/LnygoQKtaXwdo2KDbjMLR1nDN2VUWHzvBg8TkpZL
 KpEX8u0botJ9uC2WqzBsifohKEYAcO6eeukFBMmwHPagb0+V2BXF5wkQ72JhDLPXQE3+
 F3FpWvm7nTJB1KAXHTWXWbfm7XrTic1PRRj6NX8tt22+tDC7KZVdXU6KQMtMUNsZ6X4e
 dQ32I6M+6u29ZPw0VPpeQpLjREnsEkznwG1itsj6vK4A6rwLcQ2ByDOeuK4Ym7E5Hxlr
 o0J+mTmofA9FaggBIromGfYSCh8No/sFAwbWzT3EhA2ILjkJpvHuyzwY4YY6E+9XS02q hA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2x1bbphjb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Dec 2019 18:45:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBLIhh1f103306;
        Sat, 21 Dec 2019 18:45:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2x19f5kjwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Dec 2019 18:45:11 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBLIj98c006721;
        Sat, 21 Dec 2019 18:45:09 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 21 Dec 2019 10:45:09 -0800
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        martin.petersen@oracle.com, Stanley Chu <stanley.chu@mediatek.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Dec 20
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191220160639.3406a5de@canb.auug.org.au>
        <CADYN=9JjqvNWEsHLW5+GgSvkUkuz_6iMpD=X4Vk6nLQXtXa2Dw@mail.gmail.com>
Date:   Sat, 21 Dec 2019 13:45:06 -0500
In-Reply-To: <CADYN=9JjqvNWEsHLW5+GgSvkUkuz_6iMpD=X4Vk6nLQXtXa2Dw@mail.gmail.com>
        (Anders Roxell's message of "Fri, 20 Dec 2019 12:55:10 +0100")
Message-ID: <yq1tv5t7c25.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9478 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=855
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912210165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9478 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=933 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912210165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Anders,

> ../drivers/scsi/ufs/ufs-mediatek.c: In function ufs_mtk_setup_ref_clk:

This change was very briefly in my tree. It has since been dropped.

-- 
Martin K. Petersen	Oracle Linux Engineering
