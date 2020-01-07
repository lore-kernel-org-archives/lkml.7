Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1DBC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0125F2080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="mnLk+xmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgAGVdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:33:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51521 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgAGVdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:33:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id d73so369498wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 13:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xZAQ8Ekh53UEG1fNAHOy7QMbrIq+BWbSBuTOFwOjtQU=;
        b=mnLk+xmYv68qOs7TbOTaESb11Ld8Xs1P12Ib9nJhuT/hD8iO1xDv0+6OyQAEg1fiZN
         LNCnl8clRVRLgkSwK8rw2If19ebhz2323USKBymDgfgqe3O8cethuo2ue+m14W70zkTp
         egJm9Lf/i4IhjbYI4VX/fYIi+CPz1DpNCnY5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xZAQ8Ekh53UEG1fNAHOy7QMbrIq+BWbSBuTOFwOjtQU=;
        b=RV42O6V8IBKbrF4QPbQGCnG1GXr7EE+z1bYJExDSSdVacdMzJCRxCVrzI73Sdhw1lE
         Y0polJxKkjyX8L1kNcEqMAbq2yjv9JiE1uKSvpvjBAjY7AEauxTt5PIDJOftkqunyB+A
         PxTaoB+QpYuCoQ58uAyWoNm/jrRS17FUyr99CTYZp8wixNxk/87jGurDqNVMxkLHTX1O
         Qp/GYNYCj2Yi+wBXrzpamS8Dy+xQSCKtIGM7Nrv2TJDsz2MdIBG+zuVhZ/up48Sjqx1T
         jbR/KIAMR7iRvZzjFmmP7pWeACd+1SIHic67QIQugmlvxfpO1DeeWN5D6oLwyuBpb1ao
         qXUw==
X-Gm-Message-State: APjAAAVL+l7TyhWFfKBuZo2IH2E6AicyKwIcvCx75ZnnmZQelbn4pdso
        yP8cVp2Ardkx99jD2b4g8thbMwTFli3lDw==
X-Google-Smtp-Source: APXvYqyBWug6p3XxjbvaJCRcJZC769sv7VnEvTrbzf1600cBSWSHGw6BOIoOeXdeNCvrAa8JhGnTug==
X-Received: by 2002:a1c:4907:: with SMTP id w7mr358178wma.106.1578432809142;
        Tue, 07 Jan 2020 13:33:29 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:2344])
        by smtp.gmail.com with ESMTPSA id t1sm1094588wma.43.2020.01.07.13.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 13:33:28 -0800 (PST)
Date:   Tue, 7 Jan 2020 21:33:28 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/3] mm/migrate: clean up some minor coding style
Message-ID: <20200107213328.GB666424@chrisdown.name>
References: <20200107211208.24595-1-rcampbell@nvidia.com>
 <20200107211208.24595-3-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200107211208.24595-3-rcampbell@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ralph Campbell writes:
>Fix some comment typos and coding style clean up in preparation for the
>next patch. No functional changes.
>
>Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>

Looks fine.

Acked-by: Chris Down <chris@chrisdown.name>
