Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCA2C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3340D2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfH2R1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 13:27:11 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:44648 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfH2R1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:27:09 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i3OCN-0005oh-80; Thu, 29 Aug 2019 19:27:03 +0200
Message-ID: <605f243573cd0e0f14c995f6850984b4dca2a50c.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Rewrite host RNG driver.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dark <dark@volatile.bz>, Richard Weinberger <richard@nod.at>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        anton ivanov <anton.ivanov@cambridgegreys.com>
Date:   Thu, 29 Aug 2019 19:27:01 +0200
In-Reply-To: <20190829130804.5e644540@TheDarkness>
References: <20190828204609.02a7ff70@TheDarkness>
         <CAFLxGvyiviQxr_Bj57ibTU4DQ1H5wQC4DE5DNFBtAFoohcgbsg@mail.gmail.com>
         <20190829103628.61953f50@thedarkness.local>
         <1851013915.76434.1567092659763.JavaMail.zimbra@nod.at>
         <20190829130804.5e644540@TheDarkness>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-29 at 13:10 -0400, Dark wrote:
> (I'm unsure of how to submit an update
> to my patch so I'll need a bit of guidence on this.)

Resend the patch, but use --subject-prefix 'PATCH v2' and ideally note
somewhere in the patch (possibly after a "---" marker after Signed-off-
by) the changes between the versions, like

[...]
Signed-off-by: ...
---
v2:
 * fix -EAGAIN handling
[...]

Hmm, but looks like you didn't actually use git send-email directly, so
I guess just put "[PATCH v2]" manually.

johannes

