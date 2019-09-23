Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF2EC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77DC207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfIWPFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 11:05:33 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46492 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfIWPFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:05:32 -0400
Received: by mail-io1-f68.google.com with SMTP id c6so21038249ioo.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 08:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JuX2rLU57GT+Y8rUnSSH6B3s8i9gk/5paFdgTU9DWiY=;
        b=a6w26WXLXNRa0MOC4dciQIuJMLOKWm/2DzEnEhVFKktm5D9Bk8pcrXIWtoF6R74+qI
         01SZexMIgTHHa6VIn+TJStgVcE8OO8nyl6Oob99K8QtV9bp7AgkbBPl1y60HyqbZOL7P
         efX/oQvT4S6nmJxC676xJlX50yYBejd60dGIQkWu+/jy/v8XFVSyvQ0J2YifQOuqPLod
         digGOQ4Kkgf0vhtcwBPXilQ/X8I6aVhQHVi8g9zEL5zA88/s392GiwZIKnQfSJvtu2SI
         wBpvGk++2RQCmjI4t3NJSHqxEov8xiP54pIuceUUNOepXrw26d1sexcZgfCtQPLesEx+
         DRVw==
X-Gm-Message-State: APjAAAU6R3+vCDRfBdbXiocoTwIiUVBkXXFkh+WW7UiNzqL3k9Q7Ws1Q
        CZJGf/H9vCdoxspY/JRgN95B7A==
X-Google-Smtp-Source: APXvYqzNYw1uoc+qJws3WvoJ6LDxJQjnnp1OTVsd2EZQW61C+MP2pNPFjJ92YMGHdXL2vegLiYGqkA==
X-Received: by 2002:a6b:6f0e:: with SMTP id k14mr2098114ioc.255.1569251131775;
        Mon, 23 Sep 2019 08:05:31 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:82e0:aef8:11bc:24c4])
        by smtp.gmail.com with ESMTPSA id p26sm7881515iob.50.2019.09.23.08.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 08:05:30 -0700 (PDT)
Date:   Mon, 23 Sep 2019 09:05:26 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci: Check card status after reset
Message-ID: <20190923150526.GA116813@google.com>
References: <20190904164625.236978-1-rrangel@chromium.org>
 <6e65c246-a485-91c8-53e1-2ad0319a1e89@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e65c246-a485-91c8-53e1-2ad0319a1e89@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 03:31:59PM +0300, Adrian Hunter wrote:
> Should have Acked this ages ago, sorry :-(
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, and no worries :)

Ulf, The patch set is ready to merge now :)
