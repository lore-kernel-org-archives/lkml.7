Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6779FC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8DC21773
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfG2QFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:05:02 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:33999 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfG2QFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:05:01 -0400
Received: by mail-pg1-f172.google.com with SMTP id n9so22265999pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Q6zgkiKb/Gd7Bt28AZb9x/L21R06SSNq+vVR2ehC3ic77ZSGcj0paMfeUd5ySsK3eL
         xAMeKIP0vLBIuQOSoxChBHT7yx7Wx8kjTA+87D82+CVuEsMGjiLCFIc0TconSskanblq
         oUs3LU2+RV29nAAMNSjs4PPNj0aFTdaXJ1GC10c+xF2EvPknZCb8XmS046QlYq9Dm+12
         jOaSE89FQrAy/C8LDfLpMYlJd8iX2iE3x4SGiT4XgUYteuTS24ciG5fxtJLfvkRAANlA
         0WbcW5zF3dqpko9jNmkZ7q9l+ud6qosmkl99ukU7LY//pEWYt2cjrFnqy8Z5LYcXybOz
         nq0w==
X-Gm-Message-State: APjAAAX41Ssgi9beOkSeEte3e3TSIB1LszZmNyl3JHQI4RE+3NOrMrI2
        ZCObE0OA26DzswvczJ29yQuXFYzj
X-Google-Smtp-Source: APXvYqyiCdqhLpMNGuaStDGawLs5rj8J4cNHidUqnBeKUqNl16SpiN5MPJj5Qjf9Rp3D4LgzN1hF8w==
X-Received: by 2002:aa7:86c6:: with SMTP id h6mr37968352pfo.51.1564416300700;
        Mon, 29 Jul 2019 09:05:00 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:68b1:d8a0:b9e3:285e? ([2601:647:4800:973f:68b1:d8a0:b9e3:285e])
        by smtp.gmail.com with ESMTPSA id b30sm89408930pfr.117.2019.07.29.09.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 09:04:59 -0700 (PDT)
Subject: Re: [PATCH] nvme/multipath: revalidate nvme_ns_head gendisk in
 nvme_validate_ns
To:     Anthony Iliopoulos <ailiopoulos@suse.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190729124040.16581-1-ailiopoulos@suse.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a2a4f819-463b-ed8a-e108-fde2acb79dec@grimberg.me>
Date:   Mon, 29 Jul 2019 09:04:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729124040.16581-1-ailiopoulos@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
