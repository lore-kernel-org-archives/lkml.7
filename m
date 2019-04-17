Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397DDC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071BE20821
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbfDQRVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:21:25 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:35789 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732746AbfDQRVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:21:23 -0400
Received: from collins (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 1D15A20000D;
        Wed, 17 Apr 2019 17:21:19 +0000 (UTC)
Message-ID: <943166ee9799daf50615b1148f3f855aa90e9c84.camel@bootlin.com>
Subject: Re: [PATCH v4] media: docs-rst: Document m2m stateless video
 decoder interface
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Dafna Hirschfeld <dafna3@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 17 Apr 2019 19:21:19 +0200
In-Reply-To: <ec607c4917cd205f69de9a19c13a2109ff602477.camel@ndufresne.ca>
References: <20190306080019.159676-1-acourbot@chromium.org>
         <371df0e4ec9e38d83d11171cbd98f19954cbf787.camel@ndufresne.ca>
         <da5aa9ab957923a72e30b169a3c242c4fe6260f1.camel@bootlin.com>
         <c07703459c7e48904bd7fd83be1e675c70eee83c.camel@ndufresne.ca>
         <d81d0112b99feba0a1899f3722077a4aeec9860c.camel@bootlin.com>
         <439b7f57aa3ba2b2ed5b043f961ef87cb83912af.camel@ndufresne.ca>
         <59e23c5ca5bfbadf9441ea06da2e9b9b5898c6d7.camel@bootlin.com>
         <0b495143bb260cf9f8927ee541e7f001842ac5c3.camel@ndufresne.ca>
         <f4561d1b89464341b66b87af90f0d47a5b093b57.camel@bootlin.com>
         <ec607c4917cd205f69de9a19c13a2109ff602477.camel@ndufresne.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mercredi 17 avril 2019 à 12:17 -0400, Nicolas Dufresne a écrit :
> In general, we say stateless from a HW point of view. It simply means
> that the HW (the accelerator) can be multiplexed to process several
> independent streams. While with stateful firmware, you generally can't
> save the state, and ends up with a specific number of concurrent stream
> (scheduling happens in the firmware). There is exception to that of
> course, the newest Amlogic/Meson video decoder allow for saving the
> decoder state. The registers are undocumented, since they are filled by
> the HW parser, but it's separated in a way that we could multiplex.

That's a nice summary! I think it constitutes a good definition of what
we should call a stateless decoder. Perhaps we could write it down in
the spec somewhere?

> Of course we do have a state in our drivers. Each time you open an m2m
> device, you create an new instance which will keep track of done jobs,
> pending jobs, active format, allocated memory, etc.

Yes, definitely.

Cheers,

Paul

