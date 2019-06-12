Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2386C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A164821019
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JaJbjrNe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SYsHUPKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389642AbfFLRyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:54:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52490 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbfFLRye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:54:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0317C6079C; Wed, 12 Jun 2019 17:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560362073;
        bh=Hht43qaphXHsqoJvwabinU/2njLIAArwWX/pBi24330=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=JaJbjrNetcmVWhp0vIULfBJMC7Gn3rVFXIH2W0fQEjdk2Bp93NrMfTd8qbm7qYhCT
         y9kp2li83z87bcDBKPKlpR0+zjJrPRgU2GCIreuvhgfS9yXVqM44kgc/FCG4R8Q7QN
         I1Onk0464GrBEEMb6fmYt5jI1miQvQYT8j4EvjO4=
Received: from sdias (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sdias@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C95361196;
        Wed, 12 Jun 2019 17:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560362071;
        bh=Hht43qaphXHsqoJvwabinU/2njLIAArwWX/pBi24330=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=SYsHUPKoD8mJbXCmJ0hiPa/v3qQYSR4BeMdPdPqLScwGtvtuMLPtzCjs8S7HgYPt9
         2m7FG2a4IIZflVvpzg22ifDI+PRPpXmVJ78Tls5WG+4y2jCNI11T1DsjNSk6rrDF++
         DmSe8/szizaX6BaXBlKs/DomfJ53gju4agD0oSz0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C95361196
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sdias@codeaurora.org
From:   "Sujeev Dias" <sdias@codeaurora.org>
To:     "'Daniele Palmas'" <dnlplm@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, <truong@codeaurora.org>
References: <1531166894-30984-1-git-send-email-sdias@codeaurora.org> <1556637058-22331-1-git-send-email-dnlplm@gmail.com>
In-Reply-To: <1556637058-22331-1-git-send-email-dnlplm@gmail.com>
Subject: RE: MHI code review
Date:   Wed, 12 Jun 2019 10:54:30 -0700
Message-ID: <000c01d52147$e33147f0$a993d7d0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQG0yIhPO79iSUqpSJr5eu5vZGCAwAIYoKrIpsg424A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniels

Sorry for delay response.  Yes, we will be pushing new set of series very
soon that will have support for 55 as well.  The series that's pushed should
already work for SDX20, 24 and 55.   There are some new features related to
55 that's not yet in series.

Thanks
Sujeev 

-----Original Message-----
From: Daniele Palmas <dnlplm@gmail.com> 
Sent: Tuesday, April 30, 2019 8:11 AM
To: sdias@codeaurora.org
Cc: linux-kernel@vger.kernel.org; truong@codeaurora.org; dnlplm@gmail.com
Subject: Re: MHI code review

Hi Sujeev,

> Hi Greg Kroah-Hartman\Arnd Bergmann and community
>
> Thank you for all the feedback, I believe I have addressed all the 
> comments from previous patches. Also, I am excluding mhi network 
> driver in this series. I still have some modifications to do.
>
> Please review the new patch series and share your feedback.
>
> Thanks again
>
> Sincerely,
> Sujeev

are you going to continue working on this series?

Can this series be used with PCIe SDX20/24/55 based modems?

If yes, it would really be important to have this integrated into an
official kernel.

Thanks,
Daniele

