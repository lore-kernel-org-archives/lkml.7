Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B23C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9B6206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="S/BN8+l+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfEPIPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:15:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53614 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfEPIPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:15:36 -0400
Received: from [IPv6:2003:ec:2f0d:4a00:5552:641d:f8e2:cac7] (p200300EC2F0D4A005552641DF8E2CAC7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:4a00:5552:641d:f8e2:cac7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B002D1EC0BF2;
        Thu, 16 May 2019 10:15:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557994535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ewtqx+bkyBMd8uS2DF/QGEeIIo6FCVdtHuG13FgBMvU=;
        b=S/BN8+l+KcoTf9YialcZ+3Hgw1yTnCUXRTRsjPLB8qwZo8Oe883h3U9+LPTXhZXjRjEU6O
        ikSoL2Ybb+jCPP9PsbfZLicFGCvceijPi7dBiE/itJlJxvo9r76tAHsHjnv5A27t857AQX
        2uKQCPW9Fraclf9umJt3SEuZ4rQuw30=
Date:   Thu, 16 May 2019 10:15:33 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <4707fb2d-b7d3-34e3-a488-8aa9bdca05f1@redhat.com>
References: <20190430074421.7852-1-lijiang@redhat.com> <20190430074421.7852-3-lijiang@redhat.com> <20190515133006.GG24212@zn.tnic> <4707fb2d-b7d3-34e3-a488-8aa9bdca05f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3 v3] x86/kexec: Set the C-bit in the identity map page table when SEV is active
To:     lijiang <lijiang@redhat.com>
CC:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com, brijesh.singh@amd.com
From:   Boris Petkov <bp@alien8.de>
Message-ID: <0650D79F-2B12-4A80-A37A-F318B5C9ECBC@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 16, 2019 3:12:26 AM GMT+02:00, lijiang <lijiang@redhat=2Ecom> wrote:
>OK, i will modify it according to your suggestion and post again=2E

No need - i fixed it up already=2E=20

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
