Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C74C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D2A2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbfFGRNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 13:13:07 -0400
Received: from ms.lwn.net ([45.79.88.28]:57710 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729632AbfFGRNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:13:07 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E30212CD;
        Fri,  7 Jun 2019 17:13:05 +0000 (UTC)
Date:   Fri, 7 Jun 2019 11:13:04 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Helen Koike <helen.koike@collabora.com>
Cc:     dm-devel@redhat.com, swboyd@chromium.org, wad@chromium.org,
        keescook@chromium.org, snitzer@redhat.com,
        linux-doc@vger.kernel.org, richard.weinberger@gmail.com,
        linux-kernel@vger.kernel.org, linux-lvm@redhat.com,
        enric.balletbo@collabora.com, kernel@collabora.com, agk@redhat.com
Subject: Re: [PATCH] Documentation/dm-init: fix multi device example
Message-ID: <20190607111304.767fb038@lwn.net>
In-Reply-To: <20190604182719.15944-1-helen.koike@collabora.com>
References: <20190604182719.15944-1-helen.koike@collabora.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  4 Jun 2019 15:27:19 -0300
Helen Koike <helen.koike@collabora.com> wrote:

> The example in the docs regarding multiple device-mappers is invalid (it
> has a wrong number of arguments), it's a left over from previous
> versions of the patch.
> Replace the example with an valid and tested one.
> 
> Signed-off-by: Helen Koike <helen.koike@collabora.com>

Applied, thanks.

jon
