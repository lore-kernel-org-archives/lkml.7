Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CB0C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB77D2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfEBPCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:02:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40916 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBPCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:02:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so1152902plr.7;
        Thu, 02 May 2019 08:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=anO7lfUc9r8EAyhsYOxpxvhPk9AVy84BcEYav0cFPYU=;
        b=M1Qpe/OeLR6oAHYSqABfgTgStlKhZT4wmQPHji+BvIr9t6nPYLi6ApZqpWWikylmG/
         Wb4LaC669NUIX8EZTO7L7WYtHN3oKenp4DNMMkW9K21fHAkLy22DED+/GjDtQpfs0PuP
         /wJ0ftfW1KCcuK/jUo0rCWEcGl20uWt9qpO7d6X6z8BsUuqkajQMbyT7/dVoBHma5QXW
         wSOfetvhcS7TNfkx5ZNWRWyKF6WMcMvJ6AsgYrwkkMyckER0IdzP7/213mJ7PTLo6HXh
         ObCasFEGbALGzXFr4OL6QNjA9ZgEgJdC5qY95udH8iMsip8VE/7foJsWjwXim1z7hoEa
         TKYA==
X-Gm-Message-State: APjAAAUVgp4peaxx9PZgTn77H17B9538vLzqTpwaZLRwwsbXb/Jq9PSB
        vy9Og+Kb50OyeBhaHyc/mlI=
X-Google-Smtp-Source: APXvYqxwYBE+nRYoUncXZj3vOczocwKkkzBuY9BeY7WD4f0ITDINtwsG7p6VdGfcMssfK86gE2PKvQ==
X-Received: by 2002:a17:902:7892:: with SMTP id q18mr4274244pll.163.1556809361485;
        Thu, 02 May 2019 08:02:41 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id r197sm54790824pfc.178.2019.05.02.08.02.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 08:02:40 -0700 (PDT)
Message-ID: <1556809358.12970.4.camel@acm.org>
Subject: Re: [PATCH 10/24] scsi_transport_srp: switch to SPDX tags
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Hannes Reinecke <hare@suse.de>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>, Willem Riede <osst@riede.org>,
        Doug Gilbert <dgilbert@interlog.com>,
        Jens Axboe <axboe@kernel.dk>,
        Kai =?ISO-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-scsi@vger.kernel.org, open-iscsi@googlegroups.com,
        osst-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Date:   Thu, 02 May 2019 08:02:38 -0700
In-Reply-To: <20190501161417.32592-11-hch@lst.de>
References: <20190501161417.32592-1-hch@lst.de>
         <20190501161417.32592-11-hch@lst.de>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-01 at 12:14 -0400, Christoph Hellwig wrote:
+AD4 Use the the GPLv2 SPDX tag instead of verbose boilerplate text.

Acked-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

