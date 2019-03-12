Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14AAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20E9205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PoVVkFel"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfCLSGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:06:17 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:40160 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfCLSGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:06:15 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 47C4310C1E32;
        Tue, 12 Mar 2019 11:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1552413975; bh=DxGZ0JdDJOBMqAkmOeOZi2H+AXFI2JUzDuO3R2Onbqs=;
        h=From:To:CC:Subject:Date:References:From;
        b=PoVVkFelgY201pKoeaAAmkdfRHeJCiIxwzqGf19FM2nB7+BYXjgPhbhvg2tX5l7pr
         I/622Yqpxu2bTzQkiFa+4UTiMdkLfnFf1mJXRcAlJaUjHs+vaNg5iz+yoN77jPQ2vy
         eDJFpX4mq/DiJnrdhPdR5Ogooc0A2syAtspVEbGHhUAExytkoTwsZ0mUFKLyLZzcag
         y8cqIz9O2x6HxUZkXpqeR5Eri2GsfkzAcKZelEVa04DmFBM7BLi0iFEHFPmRtZXecO
         MNZKpkc9w9L9mBQdy6Uzdo4a5gINxfdENQHbPGDeaeLcuo48aitd68j5T6xzrZg+bv
         kmrM4K/IYyVEQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 39213A005D;
        Tue, 12 Mar 2019 18:06:15 +0000 (UTC)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Tue, 12 Mar 2019 11:05:35 -0700
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] arch: arc: Kconfig: pedantic formatting
Thread-Topic: [PATCH] arch: arc: Kconfig: pedantic formatting
Thread-Index: AQHU2BJ5ejZAZe4FPkqdFeRuTZR3IA==
Date:   Tue, 12 Mar 2019 18:05:35 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014643BBFF@US01WEMBX2.internal.synopsys.com>
References: <1552312679-26388-1-git-send-email-info@metux.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/19 6:58 AM, Enrico Weigelt, metux IT consult wrote:=0A=
> Formatting of Kconfig files doesn't look so pretty, so let the=0A=
> Great White Handkerchief come around and clean it up.=0A=
>=0A=
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>=0A=
=0A=
Applied.=0A=
=0A=
Thx,=0A=
-Vineet=0A=
