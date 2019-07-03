Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C656DC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 23:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9922187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 23:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfGCXtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 19:49:41 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:33525 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfGCXtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 19:49:40 -0400
Received: by mail-oi1-f173.google.com with SMTP id u15so3551101oiv.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 16:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=MK8X2JBkBCPF1Im/XK2FCLUhKyKfsrG9WFPSb3zfOPdhLV99UrzfP+1M4XquttPq1h
         PmdPGhem5yT+ZdwKm8maHlfphrIpzSWRbj1z2q3taZfdXrEXxYbSFR2gJ/qWW0rlnq+a
         0l2sYbvX+RaD9/q+oaTkFzyJKRuEo5+Ohl8op60ni4FY6vB7qXRX7PiV+we5slUFqYKk
         OP3vKYq6r4KGd/pWWP5B1U1uTaQe+BQk2E5+/xYUElLWxBafO8Y48ag7FNC5eaObVmbt
         2rP7f1qyTLq8CqbUI44uTHVihOrZiQQa78QOdLnZCfrD8mjaf63iWoJrPpeJBIqjF1bw
         7umQ==
X-Gm-Message-State: APjAAAWEPHB5abOcDiOPfLIB+uUGWm12IZhc2gmzKNrljOqQJerOvTkq
        Cr4fSOtRDJhh4lo/1KVA2jE=
X-Google-Smtp-Source: APXvYqwRjZGgQdv1gBF/qPQaeqqTknjYw1knpnjJc0FbK3DbELJLE2T8hCPFY+bZjLS0aVudaXh0MA==
X-Received: by 2002:aca:fd4e:: with SMTP id b75mr153998oii.129.1562197779924;
        Wed, 03 Jul 2019 16:49:39 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id 198sm1398677oie.13.2019.07.03.16.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 16:49:39 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] nvmet-loop: Flush nvme_delete_wq when removing the
 port
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>
Cc:     Stephen Bates <sbates@raithlin.com>
References: <20190703230304.22905-1-logang@deltatee.com>
 <20190703230304.22905-3-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3a3976b9-3d67-b9d4-69c2-6ba61c3da953@grimberg.me>
Date:   Wed, 3 Jul 2019 16:49:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703230304.22905-3-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
