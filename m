Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A71C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30F32064A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfHNUOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 16:14:54 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:41585 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfHNUOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:14:54 -0400
Received: by mail-oi1-f179.google.com with SMTP id g7so74727612oia.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 13:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yYK0sqvA5olIT1mzlTwluGr45n8/MIXVDp4G/KMif8s=;
        b=Du8tW962YjMoUyzlptFaRsgOJxihNoo60Enu2OR1a8xxFdMkCDukPyhRjZWJikSoTr
         REapm6PKIoe/msobE1sTbW/FVd9WZC0ByHeiDmkVt3bwAFMY8xFOCbc8euH01Yff7oa2
         MeiRe9sdNKhDgA4Umz4XZ8hpw2MxM8Bm1vu6TTX6FaPilIBAa9kXGeKH5WRy9zU0Z5dK
         8EY6uDSdiNiQQ/fR+AJ8c/z6Ts9oahs3REygkAWmXmIJgtFEuuXGqtadJSbqNORl0a5k
         urTweN0AuOAARhwk/yL2HsknQTwd4QGgWUgo8HV/QX0LlKiLB9L0FvzMPcsmrc7h4doD
         5mAA==
X-Gm-Message-State: APjAAAXNOOk1e7PADzwJ1MG4ZtqN7TRCdqWI04KXY9UBchB/fnbbb8EX
        YuJ3fv0Jb5ifmEw8guCnbyU=
X-Google-Smtp-Source: APXvYqys3Sqim6uIWQgcc1+U9sk7N3oy0MlqgoOfdvovOya+wHbv047sTO5413ImSvmlWv3ka+cw3w==
X-Received: by 2002:aca:4f07:: with SMTP id d7mr1266288oib.70.1565813693600;
        Wed, 14 Aug 2019 13:14:53 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id o82sm351227oig.27.2019.08.14.13.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 13:14:52 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: Add quirk for LiteON CL1 devices running FW
 22301111
To:     Mario Limonciello <mario.limonciello@dell.com>,
        Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ryan Hong <Ryan.Hong@Dell.com>, Crag Wang <Crag.Wang@dell.com>,
        sjg@google.com, Charles Hyde <charles.hyde@dellteam.com>,
        Jared Dominguez <jared.dominguez@dell.com>
References: <1565813304-16710-1-git-send-email-mario.limonciello@dell.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <32f20898-b9af-eee0-97de-0a568de54b57@grimberg.me>
Date:   Wed, 14 Aug 2019 13:14:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565813304-16710-1-git-send-email-mario.limonciello@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mario,

Can you please respin a patch that applies cleanly on nvme-5.4?
