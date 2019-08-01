Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EE3C32751
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 01:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B8020693
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 01:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfHABC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 21:02:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34234 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfHABC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 21:02:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id b13so32853710pfo.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 18:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GbYit1a5D8rEwLMyMArcrhnCQRGQCS4YYQcJAe/0Ln4=;
        b=CXP/Q1/nzc10B0Aa660Q9xIkHkjRlgl+pFMLzIabxQdcAwnmY7ebOmQGAP0zHXlt8H
         NEP08VqBTcv36RmrwssfScBma5tAIqUXuk5ahh8WhW89CoKRa5QpHc+zwxuyQWMX+mva
         KekrPzOSo9DlitroF1YNFhCboKprxKAHBVJUBbk5PzUsH/HfbO/TMn9GOs1weI1rL4SA
         ZDmuqAeWLyRw54p0lw5H3zqPMA2NGuWBE8P4HhMpLZqM47g/UAjtQtzeTZqreC5IMoil
         ox3evAQ2v2vTE4mSrOrx47+JLaPlob/bV46C86kyniTB8xOUvAuAvPQuM7TFtC4e836/
         cgnQ==
X-Gm-Message-State: APjAAAXnzCWv4pDoMIEQ62DCJP1N/ZjtwyeE/c4+2hdqgOcAEYp+44rJ
        LN+j+LdR01Fa9OlRKopwYzc=
X-Google-Smtp-Source: APXvYqzgSwGraMxmkyeBlFGqAmY8qdlWkjCvi9suIm/XDMg4NNq2vYm+NG3ihoumu0Zh6a2ZEucHKA==
X-Received: by 2002:a63:188:: with SMTP id 130mr114842632pgb.231.1564621376041;
        Wed, 31 Jul 2019 18:02:56 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:45eb:53c1:ba3f:2a0a? ([2601:647:4800:973f:45eb:53c1:ba3f:2a0a])
        by smtp.gmail.com with ESMTPSA id z63sm43268250pfb.98.2019.07.31.18.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 18:02:55 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] Varios NVMe Fixes
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>
References: <20190731233534.4841-1-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3f9c1d7d-edb0-f4b5-dc48-fe0f061b1e17@grimberg.me>
Date:   Wed, 31 Jul 2019 18:02:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731233534.4841-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.3-rc
