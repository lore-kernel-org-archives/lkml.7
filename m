Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658E4C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FAB2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfIKRVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 13:21:20 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43528 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbfIKRVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 13:21:20 -0400
Received: by mail-oi1-f195.google.com with SMTP id t84so14785981oih.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 10:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A1/ETkpc6G5lmIiqCjrYZygtKs+ulwm0ZGxJ4xV62tI=;
        b=AGLr9rL6e2DdV6PvDqGuCbHgbLuX12DxhOqs8mNkp3pM3Z43BEORtqhnQjWCjXVh1d
         JVb/u2DY/2VN4LayCng42iOkyKQYbKFhn+boBNa/FvPDpRsVTA0pwX4vzgu3n0LLGbZb
         ZngCRMpx9ARElSjFe82vmJLRngwVd2j0SpAbepbO/I2SPPTDdKkBkmFB7yN95yPv2v8W
         U8ydG1/w9/dPQo8LycqZIINn9FVbZTvvxuqitB9EYIJudvoMyAcR+F6yBhRF45wv/VvQ
         IbtgeBByS7rzaYIIj6JeIvHZG6h2L+A6St49C4xgEH9l5nWEjY+NNjBOTsg6+ehVCOW9
         Kmww==
X-Gm-Message-State: APjAAAVrM8hjctov4sz87Lb2ZuV5XF1eo2x7N3sgT78YGhFpbeijZscS
        2p0rioUs1pZEYbSg23yrT18=
X-Google-Smtp-Source: APXvYqxqZ+haTwVi3/MKjiTUTVQ1QsehIAv7tF1qipiAoQyKJTn6/7c+pIHjMecml9oTBwCRiMA/PA==
X-Received: by 2002:aca:c550:: with SMTP id v77mr4881558oif.93.1568222478126;
        Wed, 11 Sep 2019 10:21:18 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id o4sm7789027otp.43.2019.09.11.10.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 10:21:17 -0700 (PDT)
Subject: Re: [PATCH] Added QUIRKs for ADATA XPG SX8200 Pro 512GB
To:     Gabriel C <nix.or.die@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <CAEJqkgivvhQ=tOOuLjY=iwBVCKQhmmjpfNDa1yJ5SreNQubw6Q@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4581016e-b421-e794-e603-807d37aa1bf3@grimberg.me>
Date:   Wed, 11 Sep 2019 10:21:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEJqkgivvhQ=tOOuLjY=iwBVCKQhmmjpfNDa1yJ5SreNQubw6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This does not apply on nvme-5.4, can you please respin a patch
that cleanly applies?
