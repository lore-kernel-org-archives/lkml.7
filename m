Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7D1C31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6F82084D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="A5W2o0Hx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbfFRHrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:47:42 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:53008 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfFRHrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:47:39 -0400
Date:   Tue, 18 Jun 2019 05:18:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1560835085;
        bh=ROX6bjPyMCjURrFP35KVTXnHB9n+5ry9VMvQqgDRnxs=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=A5W2o0HxvP2s920wLWi3sSQvkYYoUu1v9V6xJZwg0tGUAIcxCec8MHDd5Yal57vnR
         uPZAIAwajPfNNDS1N4QayDL9CFvSyvAs64WDV9CRw4DtRGi4vg87uHf/2hqGUOr1Z8
         yjnjFJUp70yORYIvnVHGveLvz4Vb83XIGODkYL5U=
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 1/2] drm/vkms: Use index instead of 0 in possible crtc
Message-ID: <WQuF2MGabt8DxA1rdWhTcZIGSaXav-5XOae4hkdkxq51gom6tklMqrfOLnyN6WSm9TY5sLXp_fxoNQhtC3E7zY9A3dLEpfZ1phdw23m0SI8=@emersion.fr>
In-Reply-To: <20190618021944.7ilhgaswme2a6amt@smtp.gmail.com>
References: <cover.1559860606.git.rodrigosiqueiramelo@gmail.com>
 <e3bc263b273d91182e0577ed820b1c4f096834ec.1559860606.git.rodrigosiqueiramelo@gmail.com>
 <20190607073957.GB21222@phenom.ffwll.local>
 <CADKXj+7OLRLrGo+YbxZjR7f90WNPPjT_rkcyt3GrxomCAjOjHA@mail.gmail.com>
 <20190607150420.GI21222@phenom.ffwll.local>
 <20190618021944.7ilhgaswme2a6amt@smtp.gmail.com>
Feedback-ID: FsVprHBOgyvh0T8bxcZ0CmvJCosWkwVUg658e_lOUQMnA9qynD8O1lGeniuBDfPSkDAUuhiKfOIXUZBfarMyvA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 18, 2019 5:19 AM, Rodrigo Siqueira <rodrigosiqueiramelo@gm=
ail.com> wrote:
> I made the patch, but when I started to write the commit message, I just
> realized that I did not understand why possible_crtcs should not be
> equal zero. Why can we not use zero?

Hi,

possible_crtcs is a bitfield. If it's zero, it means the plane cannot
be attached to any CRTC, which makes it rather useless.

Thanks,

Simon
