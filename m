Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359ABC00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008D2207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575990832;
	bh=aGvUfbdJAAGaGEa3eEsM+2Ah3ihhMKl45aQDqRkVHFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SFD9xI+3s+yO6yQjG4o10/SD3u9qqRBl7oH5fOM37OqwSAMEPEa82H5ECAtE6U/SM
	 pPfl2UEM5Vt9GqQo/m4Umm/yIYGc18iO6kzJ6BEOgjbIeGhZs2H/2nzvW7tR1BdwJU
	 aRE2Npa283g55MUfKorR/i07xSG9idK4IY/7SFFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfLJPNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:13:51 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34350 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbfLJPNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:13:51 -0500
Received: by mail-ed1-f68.google.com with SMTP id cx19so16314333edb.1;
        Tue, 10 Dec 2019 07:13:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+WKlQUPo72dT+6gRaE8wTfxIyY3yTGzZswBT0iRb62I=;
        b=AtA0+9FtKwNy37TEJqJRheXr4kAtb1vFijuq7jqnbL2x9OXNpjP/6I7EvV6pvbfSn/
         p/pvddkzNCRfGKdp6RAKAvBVo1Zazr0YqdlnPJq5KVEMuADPYrHudoZTgxCNKWR9PJta
         amykV68QTo81gWEf/w4XgOoGfcvP5x8QZ6Adcm3WEHfKKCW2XAesTQ6x7ZdP0ieCNCsr
         CCgQz3TKuRrknUcs6fIQQFwbFlS/VltzuF8Nuqug8DkpvxhEUN6T3IbF065M6Y3gdSVl
         B1DLt/ooRJt1LpxpSitE0jjbORvWjqRMe7o9lUX34ChDlTbEL8QlNqJq8HFJ56kWA/f/
         LHvQ==
X-Gm-Message-State: APjAAAVpQCpaSQHSQcdjukReIaWyvmX6Bw0t/08+9ZFJyngI8Vy7XDiL
        4wmfxQPKDNogMTkJbM5Wjjk=
X-Google-Smtp-Source: APXvYqyHYKpKtamdeJS3QNFEyTBoL2rxQ9sXdvJZCyjpdDzv+arjgS3g0x4xyx8CWZsUYi2fp7VhMQ==
X-Received: by 2002:aa7:d78b:: with SMTP id s11mr40051088edq.240.1575990828937;
        Tue, 10 Dec 2019 07:13:48 -0800 (PST)
Received: from pi3 ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id y17sm70501edq.69.2019.12.10.07.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:13:48 -0800 (PST)
Date:   Tue, 10 Dec 2019 16:13:45 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] tty: serial: samsung_tty: fix blank line
 checkpatch warning
Message-ID: <20191210151345.GI11222@pi3>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
 <20191210143706.3928480-10-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191210143706.3928480-10-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 03:37:06PM +0100, Greg Kroah-Hartman wrote:
> checkpatch is giving a bunch of:
> 	WARNING: Missing a blank line after declarations
> messages on this file, so fix up all instances of that issue.

I would prefer to squash it with previous. These are not bugs, just
minor coding style violations so there is no point to split it per
patch. Too much churn.

Best regards,
Krzysztof
