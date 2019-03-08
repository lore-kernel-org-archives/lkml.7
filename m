Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8625FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573D220851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cThMKfor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfCHNNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:13:32 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34018 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfCHNNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:13:32 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x28D9M0S160822;
        Fri, 8 Mar 2019 13:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding :
 subject : to : cc : from : message-id; s=corp-2018-07-02;
 bh=npJnvaYT2qdKSTTBzBogJE1+Y2rupvL9oDYt8WKIoP0=;
 b=cThMKfor3ZG+KXTj97JkbA//8PPuZA22Qy4LwfjI2cZe95RvDRVO2vDX+a9CXA6avRA6
 koe8ZHxxzfCigDJjdzd+BvhtUO5jADuHgG2Fo/k/3aS1YEXm6pkhR5dldTTzJp/dZ/ln
 j1LddA2h+5hG+n2N1yxiE+uKvn45Z8O03kUroa6dmuv9rLiZTFwSOrTzGtNUfExW+6OO
 +G0bhaQ1iT6aIMA6MnKqJIJcRyfHk/VhqScmYd/an5sdJ4YuoTA566SEE8pseyTjX9uQ
 lte2twgCKOKdty5tsgSm65oMxRdQc2wr6BczO4rZtq02hjsuZouhD0c/virPSdgtQ5PK AA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2qyfberehs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Mar 2019 13:13:08 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x28DD2gQ031354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Mar 2019 13:13:02 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x28DD1sX026926;
        Fri, 8 Mar 2019 13:13:01 GMT
Received: from [IPv6:2607:fb90:2973:efa2:d397:64ff:27ad:406d] (/172.56.23.181)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Mar 2019 05:13:00 -0800
Date:   Fri, 08 Mar 2019 08:12:57 -0500
User-Agent: K-9 Mail for Android
In-Reply-To: <20190308114310.25041-1-jgross@suse.com>
References: <20190308114310.25041-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] doc: add boot protocol 2.13 description to Documentation/x86/boot.txt
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
CC:     x86@kernel.org, corbet@lwn.net, hpa@zytor.com, bp@alien8.de,
        mingo@redhat.com, tglx@linutronix.de, mfleming@suse.com,
        ross.philipson@oracle.com, daniel.kiper@oracle.com
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <D3212816-1FE7-44B3-9CF6-299EF830BC0A@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9188 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903080094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On March 8, 2019 6:43:10 AM EST, Juergen Gross <jgross@suse=2Ecom> wrote:
>Documentation/x86/boot=2Etxt is missing protocol 2=2E13 description=2E
>
>Signed-off-by: Juergen Gross <jgross@suse=2Ecom>

You forgot Reported-by: Ross Philipson =2E=2E=2E

And pls feel free to add Reviewed-by from me as well=2E
>---
> Documentation/x86/boot=2Etxt | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/Documentation/x86/boot=2Etxt b/Documentation/x86/boot=2Etxt
>index f4c2a97bfdbd=2E=2E223e484a1304 100644
>--- a/Documentation/x86/boot=2Etxt
>+++ b/Documentation/x86/boot=2Etxt
>@@ -61,6 +61,10 @@ Protocol 2=2E12:	(Kernel 3=2E8) Added the xloadflags
>field and extension fields
> 		to struct boot_params for loading bzImage and ramdisk
> 		above 4G in 64bit=2E
>=20
>+Protocol 2=2E13:	(Kernel 3=2E14) Support 32- and 64-bit flags being set =
in
>+		xloadflags to support booting a 64-bit kernel from 32-bit
>+		EFI
>+
> **** MEMORY LAYOUT
>=20
> The traditional memory map for the kernel loader, used for Image or

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
