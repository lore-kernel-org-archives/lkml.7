Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11BDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899F4213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfCTMrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:47:25 -0400
Received: from ozlabs.org ([203.11.71.1]:52619 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfCTMrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:47:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44PV7H651zz9sPC;
        Wed, 20 Mar 2019 23:47:23 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3] powerpc/mm: move warning from resize_hpt_for_hotplug()
In-Reply-To: <663cdede-afd1-bafa-3979-e820214f029d@redhat.com>
References: <20190313102528.4632-1-lvivier@redhat.com> <663cdede-afd1-bafa-3979-e820214f029d@redhat.com>
Date:   Wed, 20 Mar 2019 23:47:22 +1100
Message-ID: <871s31zp9h.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Vivier <lvivier@redhat.com> writes:
> Hi Michael,
>
> as it seems good now, could you pick up this patch for merging?

I'll start picking up patches for next starting after rc2, so next week.

If you think it's a bug fix I can put it into fixes now, but I don't
think it's a bug fix is it?

cheers
