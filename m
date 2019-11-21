Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E446C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93EA2089F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574320962;
	bh=YADEyjm7guxEoLaCkxuDN8e12OturEk30iMb1m0sXy8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LHrHSWRfCoKAkMbYR5nKTDWzT6/1FbZKlPu92IJgLeq3lcVnMgjUv0Ww4MZgH0jGO
	 GCKRAwr8NSgiyGOYgIXlLPcCpIAuGOvCYKPmA0KlU+KpamNZgA1PA4Bobn+X7J43HN
	 4IJJ62KzY/T26yxOLdSYMvkMpScNhr27+RC3RfyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfKUHWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:22:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:35230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfKUHWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 02:22:41 -0500
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1ABB2089F;
        Thu, 21 Nov 2019 07:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574320961;
        bh=YADEyjm7guxEoLaCkxuDN8e12OturEk30iMb1m0sXy8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KEiU3m6w1QRLPYis/nvdOXCNLlDJVzXntmLC4o8vU3pQCiVDGQI6Mx6W6pgd/uU4l
         IYbi0R1Xw/eDXYuud7ezUAOHQ4gRyiEJY+88ENSFNqdaJyjEi6I/9s/1FVQ1ChoZzK
         c6s5Dzo7eGIF404BGqwPFFLALrFTH5wDt93kgnwo=
Received: by mail-lj1-f169.google.com with SMTP id 139so2042652ljf.1;
        Wed, 20 Nov 2019 23:22:40 -0800 (PST)
X-Gm-Message-State: APjAAAWpjYOEnZjQjMMn4o0HhNoKmF6njYlgZe1FF78kcjEJwW+N2CQR
        Dj2Ohumaqadz3YJCGg0lSCRWmV2jOLYAdXRrDmw=
X-Google-Smtp-Source: APXvYqwXIosldCdyfqLaI2gnKCAKMpUmtejqgmFnVUw8bU3ySqaIdMLSDal4fqS+E60cPFhwielOTRBHCX04FcEd0TQ=
X-Received: by 2002:a2e:9842:: with SMTP id e2mr5961570ljj.93.1574320958924;
 Wed, 20 Nov 2019 23:22:38 -0800 (PST)
MIME-Version: 1.0
References: <1574306408-20021-1-git-send-email-krzk@kernel.org> <20191121072124.GA356838@kroah.com>
In-Reply-To: <20191121072124.GA356838@kroah.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 21 Nov 2019 15:22:27 +0800
X-Gmail-Original-Message-ID: <CAJKOXPeW_ffza48Bbxm7Od-Xo_Vt-Qfy+8OY5w8AzZOPkxriXg@mail.gmail.com>
Message-ID: <CAJKOXPeW_ffza48Bbxm7Od-Xo_Vt-Qfy+8OY5w8AzZOPkxriXg@mail.gmail.com>
Subject: Re: [PATCH v2] tty: Fix Kconfig indentation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 at 15:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Nov 21, 2019 at 04:20:08AM +0100, Krzysztof Kozlowski wrote:
> > Adjust indentation from spaces to tab (+optional two spaces) as in
> > coding style with command like:
> >       $ sed -e 's/^        /\t/' -i */Kconfig
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > ---
> >
> > Changes since v1:
> > 1. Fix also 7-space and tab+1 space indentation issues.
>
> Same here, I already applied v1, so this one does not apply :(

Hi Greg,

I missed your notification that the patch was applied and then I
worked on a updated version fixing few more whitespace errors (pointed
during review on other patches). This supersedes v1 but if you do not
want to rebase, I can send it later as a separate patch.

Best regards,
Krzysztof
