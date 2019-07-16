Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2CEC76191
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 01:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075C920693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 01:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbfGPBNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 21:13:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41867 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730690AbfGPBNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 21:13:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so8242678pff.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 18:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=BhnEBboyADMVWXpZk3haLUqBO6s32ViUC2O24iV0s8kO8Tx/fJF7cigXcrA1h+2qmE
         z7TcqVA7M2za1dMQ52/e4KEsMZxp/pChGFOeGtHb3Y/0UqseMfUpe/4vTRPuBTjNYK7Q
         bYjpn46vAhbx9D1cAHnZfbz3h6t+86vZ5TPAkcTS2X+KzjGNwFVqpFcBamZnPmeZZs5P
         fYFEJfL9yOpDPlYerZSHZdJWwkZzchRGRF4f3FAnTCz0iQPMIowdN803f8uw1tQOA+7s
         fe5TcGfThdCJe3pv3gmWGGS98Vtk73JA2iLEK2Y+sKo2JYAYf7xQ4uVMrpkrlUmyYitT
         Vh6w==
X-Gm-Message-State: APjAAAVMyqWY1xLIgDWbMrCNZ9QAC75IHA4eOuUBW8K2EqkCoLB2cJ7D
        l4kzBFHewbT05DyOcJ3Y10w=
X-Google-Smtp-Source: APXvYqwyOeNFiPUvfbJHqJKCimn4GBeGAwsvg4Ux9EsWnseHA+nkhuhAMyj+rqVZPHPYDpUMXw1u9A==
X-Received: by 2002:a63:778a:: with SMTP id s132mr27637952pgc.242.1563239622524;
        Mon, 15 Jul 2019 18:13:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:10a0:43d6:25f7:7bc3? ([2601:647:4800:973f:10a0:43d6:25f7:7bc3])
        by smtp.gmail.com with ESMTPSA id q19sm21050390pfc.62.2019.07.15.18.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 18:13:41 -0700 (PDT)
Subject: Re: [PATCH v2] nvmet-file: fix nvmet_file_flush() always returning an
 error
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20190715221707.3265-1-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1a6fe969-edaa-d26a-d8d9-086893324378@grimberg.me>
Date:   Mon, 15 Jul 2019 18:13:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715221707.3265-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
