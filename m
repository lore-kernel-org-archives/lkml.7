Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE11C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45BC20873
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbfEMRTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:19:15 -0400
Received: from mail-it1-f174.google.com ([209.85.166.174]:52219 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729503AbfEMRTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:19:15 -0400
Received: by mail-it1-f174.google.com with SMTP id s3so304712itk.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=edXm6nV8k9IKw8GN0v7pjwQG3EECmvNTVGBhaoXBOy8=;
        b=ChpTdLD2hrfsYv3FwzTZYnib7JpErr2Jhdq9/VLejYGFLQxvwV8DPA6CacwTJDb/Eq
         om1ETBptWbf7+hbDvODT+BPaiZA192S/d0/+unSX3DJ34LYSMOVhg4Tlt9TUVfM0asfd
         evXSM6YcrZS0oBEaT0L0jgBMW+2LIQWToCofBYJFHpgrRiJt8oq6GZyh8yWtDry1vmfz
         2B2c+siegSh2yZusHHacrvGeuQOwspouKL+qGzybpQqklJZWJwhxb0UtAjc/7cdz66jM
         X/39raPUpo7h/PrIG5MhV1xierN4R3eWDMuT0yd9IkTAyou/B5wgNN5HGNp7xb/wZvaf
         nRnQ==
X-Gm-Message-State: APjAAAVNi/Qb8TsnXQq9v5Iy8tf78kegm3P0u6xs0TG1S25wSvjfblwA
        1JYxeS6hw2Hvo4grW3lJIAvDew==
X-Google-Smtp-Source: APXvYqzzkTdZunaul5S9hyndOLjl1eWjL1tIFwSvNm8zSLCNYZNkVziz0TnYEOaYSFGWvDFTOA5LHw==
X-Received: by 2002:a05:6638:310:: with SMTP id w16mr12108468jap.130.1557767954280;
        Mon, 13 May 2019 10:19:14 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id x11sm1190741ion.10.2019.05.13.10.19.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 10:19:12 -0700 (PDT)
Date:   Mon, 13 May 2019 11:19:08 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mmc@vger.kernel.org, djkurtz@google.com,
        adrian.hunter@intel.com, zwisler@chromium.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: v4.14: Fix null pointer dereference in
 mmc_init_request
Message-ID: <20190513171908.GA37248@google.com>
References: <20190508185833.187068-1-rrangel@chromium.org>
 <20190509060456.GA17096@infradead.org>
 <20190509184234.GA197434@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509184234.GA197434@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Errm.  I think we need to fix that problem instead of working around it.
> So mmc_request_fn already has a null check, it was just missing on
> mmc_init_request.
>
So I got 189650 random connect/disconnect iterations over the weekend
with these patches. I think they are fine. I'm going to send them to
stable@ unless anyone has any objections.

Thanks,
Raul
