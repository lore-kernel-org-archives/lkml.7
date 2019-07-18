Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B0DC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 23:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882B821019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 23:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfGRXwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 19:52:40 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43723 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfGRXwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 19:52:40 -0400
Received: by mail-oi1-f195.google.com with SMTP id w79so22947472oif.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 16:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZllE0gIBJhpo05kcIgz3B2wrvprdqJzTT5m8KUHoNB8=;
        b=E3PAitKiVE9ltrfIRY+zVhzwCSbYA2Rzq+NfPynVW+AVJ5ytUQY0+CCINe7VN6H/q0
         6iabs2CJ0QvwVDdnGNu7LmmT8RN/qulzWHPIoD6ZtNgAKSzKXtBjou4/WCViZPmO4q8y
         96WYadcHFN1UCQasmqhhH3RYkmPYJUfLamwYo411rWWChb7smIxvIaAYVh9LBmIX5y+E
         PyqZT8klwIOOxej5gUFLhNiqvzevdl0ZlFZtACbvAjSgqzaCFg4c83IPxZ0BOm5SFnRn
         ribZQwWbPJZPwgVDv/E6ujFZDkp3gsI+JPvoqRMzO5BtrbOYcGlDkrEBGtch+1UVfGx0
         FQVA==
X-Gm-Message-State: APjAAAX5j4zvM8J5yTmGU5Eg/93V5kXnxuXvJ62hR5WrdK0qc1IxArGf
        r7V95dRBEg/GNJ6qarMgJ/s=
X-Google-Smtp-Source: APXvYqzTetpO/THoe8y4mQ5Fg6W661z9NC1iloekeMnNeAZy8DyrmV71kKcGfRngaOJyMv0dAUPxbA==
X-Received: by 2002:aca:eb57:: with SMTP id j84mr24378141oih.17.1563493959724;
        Thu, 18 Jul 2019 16:52:39 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id e10sm8991218oie.37.2019.07.18.16.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 16:52:39 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvme-core: Fix extra device_put() call on error path
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190718225132.5865-1-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8b47dac6-479d-c843-0a11-1de8de376a7e@grimberg.me>
Date:   Thu, 18 Jul 2019 16:52:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190718225132.5865-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good Logan,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
