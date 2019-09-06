Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E77AC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 18:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D08208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 18:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395313AbfIFSNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 14:13:50 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35867 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731928AbfIFSNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 14:13:50 -0400
Received: by mail-oi1-f195.google.com with SMTP id k20so5713550oih.3;
        Fri, 06 Sep 2019 11:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xLmL42CiB+Tx4ipPu1XCKAf8GsimAkZztJFd7tUoIPo=;
        b=odx6tKRiTIxCeZgS1pbi33M6OnQQPIahFTUqt+iMQHEHzjcujlgPKnx156XnAC/IgN
         8Od7sezhyMBRU4+8iCfwkEjPtuQN17GUTOYaXqVh/ONBHiMPZ1Dx/cT2B8PAsfEs3I6j
         cDyvheUV/vbNopT7qfx2JCh/wSZUwZkqjG/hdfPjVUMXOsqbfvSsSesTzfYz0Wvzm7It
         QpWiwLVfzIMHS+jfJ/dXeUKTqDez/FDuhvPHty9jVWpzd7/LaRk8GbyFrQHDm1HgsleR
         5FmSLIQFKQSRYSaD9Xeh2W/yc+uILnOMco5tKg2oH7tVKxldhHMN0+BA0dl8qUEmFlAe
         m9fA==
X-Gm-Message-State: APjAAAXBjhj4YrHrR09ovHpbB2urxenjmG+nWNqF95ZBvN7dHB4M66bK
        zQPru/EQt6wdb/c0lfOE8ps=
X-Google-Smtp-Source: APXvYqzBApLRYJOobIsaIXCt07zmjmoFFv2h+YoAKcXu9gQ4pb8WJq42X9wSEm3uXoLfOiTbR2v4Vw==
X-Received: by 2002:aca:4f46:: with SMTP id d67mr7832976oib.102.1567793629327;
        Fri, 06 Sep 2019 11:13:49 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id u7sm1862820otk.20.2019.09.06.11.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 11:13:48 -0700 (PDT)
Subject: Re: [PATCH] nvmet: Use PTR_ERR_OR_ZERO() in nvmet_init_discovery()
To:     Markus Elfring <Markus.Elfring@web.de>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>,
        zhong jiang <zhongjiang@huawei.com>
References: <b35ec629-f75f-2eee-1db1-98874f486258@web.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <655dc338-b7c9-cd01-1b3e-59fe34c87f6a@grimberg.me>
Date:   Fri, 6 Sep 2019 11:13:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b35ec629-f75f-2eee-1db1-98874f486258@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

applied to nvme-5.4
