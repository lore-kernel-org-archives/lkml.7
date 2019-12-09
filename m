Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F187C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CE120692
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="giGlsQnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfLIQOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:14:21 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46796 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIQOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:14:20 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB9GALHN047053;
        Mon, 9 Dec 2019 16:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=DDBb3Lws0Bln7Q3yPsjcV6BrBWhAmpQz0iFXZoZdVaE=;
 b=giGlsQnrCGDqDgomc4UoquZSV7PRsD2k7cQm2RfMgqNza20kUYpjCUHilFp0DkiKE5fb
 QOr6dPrfdHR2ilzpjtJxaqs1CU0KfDs3l53gRkg0rytjH1rQqGnnI28q4v4E7S799y/r
 4PwFmhkSRXehyzRjvFsAHVNY5IO0my80aOWjRPaEFUZDpYr2l7Xf6F71R3V+aOhXrNWA
 tN87Czw3clxzuxnoipdMDJOHfpgh4eThRyThiq7InI6TfeASDL6Q6iVlT9m/mKf7EMw8
 usL47NtHCR2+P7E3mp/qI67Fz5pUEbL/7RYQJocZqx31YCG+lOpcHWXVe7oQhyxx6YRt Tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wrw4mwd1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Dec 2019 16:13:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB9GALFE107601;
        Mon, 9 Dec 2019 16:13:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2wrp7nkv16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Dec 2019 16:13:49 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB9GDjD5015770;
        Mon, 9 Dec 2019 16:13:45 GMT
Received: from tomti.i.net-space.pl (/10.175.212.194)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Dec 2019 08:13:45 -0800
Date:   Mon, 9 Dec 2019 17:13:40 +0100
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Documentation: x86: fix boot.rst warning and format
Message-ID: <20191209161340.kdsikc2hvbhmpi6k@tomti.i.net-space.pl>
References: <c6fbf592-0aca-69d9-e903-e869221a041a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6fbf592-0aca-69d9-e903-e869221a041a@infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9465 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=988
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912090139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9465 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912090139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 08, 2019 at 08:25:10PM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix a Sphinx documentation format warning by breaking a long line
> into 2 lines.
>
> Also drop the ':' usage after the Protocol version numbers since
> other Protocol versions don't use colons.
>
> Documentation/x86/boot.rst:72: WARNING: Malformed table.
> Text in column margin in table line 57.
>
> Fixes: 2c33c27fd603 ("x86/boot: Introduce kernel_info")
> Fixes: 00cd1c154d56 ("x86/boot: Introduce kernel_info.setup_type_max")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Daniel Kiper <daniel.kiper@oracle.com>

Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>

What can I do next time to avoid mistakes like that? I suppose that
I can run something to get this warning but I do not know what exactly
it should be.

Daniel
