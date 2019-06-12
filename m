Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A985FC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB7C21019
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="f1qAl+z2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bpSQLqvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfFLSAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:00:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57228 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfFLSAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:00:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 50CDE60767; Wed, 12 Jun 2019 18:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560362438;
        bh=LAg/imbdxZTgmWTvbxX/PL3CfNQDfloWOyoCq10fgvU=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=f1qAl+z2KzC2+9FIK3fWmjYjpdd9NTrEN2dyN71qELEzAxAJYdibHu03pvuieifFt
         GT1ZIc6TkQ/ybN3OuMptK0EtyMz7bwE6BCD7aAI1NCv4Mu80eupmyD9v8AI1VfGdGA
         VNa4ssazfuxRIL+J/hr3b+wzdHxYp2Pd+m1LrA+k=
Received: from sdias (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sdias@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B013C60132;
        Wed, 12 Jun 2019 18:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560362437;
        bh=LAg/imbdxZTgmWTvbxX/PL3CfNQDfloWOyoCq10fgvU=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=bpSQLqvUUm1UHddvhhfRyPfI0vs9tMgszQKnZl9xU4xZbEUTeTsE4wTJILG2zk3LA
         5mZsCoRHMATE8ZZlhjDRSlAkwzX8q4ZsB/K/dPauR6DvQYPjD9TY/erKEBdVitfDTM
         kyL8E42j2LdG41587jO+5vaR2W9kajTyF1/pUQKo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B013C60132
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sdias@codeaurora.org
From:   "Sujeev Dias" <sdias@codeaurora.org>
To:     "'Daniele Palmas'" <dnlplm@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, <truong@codeaurora.org>
References: <1531166894-30984-1-git-send-email-sdias@codeaurora.org> <1556637058-22331-1-git-send-email-dnlplm@gmail.com> 
In-Reply-To: 
Subject: RE: MHI code review
Date:   Wed, 12 Jun 2019 11:00:37 -0700
Message-ID: <001601d52148$bd852840$388f78c0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQG0yIhPO79iSUqpSJr5eu5vZGCAwAIYoKrIAuo+QRimsOjpkA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our team also monitoring following thread
https://lkml.kernel.org/lkml/20190531035348.7194-1-elder@linaro.org/

Since this also has implication on MHI as well.

Thanks
Sujeev

-----Original Message-----
From: Sujeev Dias <sdias@codeaurora.org> 
Sent: Wednesday, June 12, 2019 10:55 AM
To: 'Daniele Palmas' <dnlplm@gmail.com>
Cc: 'linux-kernel@vger.kernel.org' <linux-kernel@vger.kernel.org>;
'truong@codeaurora.org' <truong@codeaurora.org>
Subject: RE: MHI code review

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

