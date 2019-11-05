Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB9FCA9EC7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 04:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113C42053B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 04:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="FhJB42Gy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387505AbfKEExm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 23:53:42 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:56012 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfKEExl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 23:53:41 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 476cgw5LH0zJb;
        Tue,  5 Nov 2019 05:51:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1572929485; bh=ynk/Jlv4zfIApiDvMMJssbkmr9wLbQcF3N8lX8JdzoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FhJB42GySupSrJPyjQL3OufU9k7mKEsWcFJus2/144sX8U56P+8nPlHSIofh8/QZW
         WJrU6xxxMUXvRrvvmLwu7BMCRY55E1dLA8Xvu8QqezwJ4WzqAnx9zPkvsGHM64wugw
         p3PO88gw9NzyIwvT/ffb9MWcYt6O0mZXf+2itj1iyFw23LaNxRk2QQPQ/VSmAUWvd3
         90OWSfkUF2cMwAYBodeoJZBxVfbx4e85rCakQFZmEuMCRKIUW1ZFW4CKjbcgwUxRs1
         CQs2GJQ96jNY9JMzw07OlnENdp6122UT31L6oKVSyv9lSNFxgRrcput3RkCWVQ8Hn0
         fEWvqqx4BpA9g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Tue, 5 Nov 2019 05:53:37 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Jamal Shareef <jamal.k.shareef@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, thierry.reding@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, jonathanh@nvidia.com,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] drm/tegra: Remove space after parenthesis
Message-ID: <20191105045337.GB1764@qmqm.qmqm.pl>
References: <cover.1572920482.git.jamal.k.shareef@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1572920482.git.jamal.k.shareef@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 06:23:19PM -0800, Jamal Shareef wrote:
> This patchset removes spaces after left open parenthesis.
> Issue found by checkpatch.

I'd say that those spaces make code easier to look at, so it would
be better to teach checkpatch to ignore cases like these.

Best Regards,
Micha³ Miros³aw
