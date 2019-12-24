Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0AEC2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 14:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5270206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 14:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfLXOdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 09:33:38 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38546 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfLXOdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 09:33:37 -0500
Received: by mail-lj1-f195.google.com with SMTP id k8so20954626ljh.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 06:33:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KPGZel5egxUTitPyz8859YreY0rqMEYVN3LEfGWGArY=;
        b=ZfMexf37pKFadE1te5ia/KNKGCxdWuHTW202Z3G18VMQqDRuV4GvOLfDObSSX7VSeB
         Dj2OF/rM6+0IAokF/dBSuPjfF8Yzz21Ls8Zr5sOf2ggR7SefdmMFk22vH6DYQC3OK2Cy
         NkFP62/DctXiKnZBdbL4Nw59twi1Wtsfnw4j4nkmLm/lhVjXg7CtUOLss3i7HFCB8ghV
         PNUuyPsC7UWB1GPHgmPG6BJGAFOJy3opi59VxLGQs2g5UNfzQiEbQwgWixoW3MfrErnL
         1xrAPWD3MQGs4iYoSzJ3bHbui7FaybbsyHgXhwGECEh5p96i6FTeDfwo0uyGj4gOgx2x
         lZcw==
X-Gm-Message-State: APjAAAXLM6ZbRPGufGMS3/+vJ21JYaQQYoc5Tk4QDEuALtKOkM+RxLx6
        wC1t3XFeK9AqYhZpy25olLxwYVpAhtHnuJf7vew=
X-Google-Smtp-Source: APXvYqzuaeGreMrWFNK73+Z5aaV0f3ay2vDj1XIs3xBZ2cNLsfs6UqLARsLT4D52vYwkhpz8PpPL+lsfmHCsUFe53No=
X-Received: by 2002:a05:651c:204f:: with SMTP id t15mr21645904ljo.240.1577198015769;
 Tue, 24 Dec 2019 06:33:35 -0800 (PST)
MIME-Version: 1.0
References: <20191218111742.29731-1-sudeep.holla@arm.com> <20191218111742.29731-8-sudeep.holla@arm.com>
In-Reply-To: <20191218111742.29731-8-sudeep.holla@arm.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Tue, 24 Dec 2019 14:33:24 +0000
Message-ID: <CAPKp9uZznwOgpm=CEMMUDFvHVa=jsmG0-fd4q-_=c_d3HqbKTA@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] firmware: arm_scmi: Skip protocol initialisation
 for additional devices
To:     linux-arm <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 11:19 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> The scmi bus now supports adding multiple devices per protocol,
> and since scmi_protocol_init is called for each scmi device created,
> we must avoid allocating protocol private data and initialising the
> protocol itself if it is already initialised.
>
> In order to achieve the same, we can simple replace the idr pointer
> from protocol initialisation function to a dummy function.
>
> Suggested-by: Cristian Marussi <cristian.marussi@arm.com>


Hi Cristian,

Are you fine with this approach ? If yes, I plan to apply this series.

--
Regards,
Sudeep
