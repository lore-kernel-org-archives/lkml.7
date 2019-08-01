Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E13CC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F29E20838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="NSZQCYCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbfHAVlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 17:41:50 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35922 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730273AbfHAVlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:41:49 -0400
Received: by mail-lf1-f67.google.com with SMTP id q26so51413025lfc.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 14:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wy5NJcQ2NTEJIuX16bOQiS1WPonz/S5C/OXL6ClZM8E=;
        b=NSZQCYCZlvdefAiOE6lkVFKH/0MfWEwsNqY1dvxclHpGH/1Ij8ZFhbDtHkbxPrbUJh
         Vs0FMC9vuUdWZoosLb5rHh6Kzlee6CeTvVxfDidOhK/sQBA6iUDzereRrAsmpvemrV6d
         2vwzsLgn5YE1nDj57dyRroFW1t4hh45IFXQho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wy5NJcQ2NTEJIuX16bOQiS1WPonz/S5C/OXL6ClZM8E=;
        b=sFFjMCiAGLIebc7VdwSWnvmIr5BBOHDePPmFLQEFQkPA1iw+RC+eURxgFDDkGFsoC/
         QYJUXihgdys0us8LeM5SHumKSPiHztPb3EVTQPHsjqGnCgQBUDUx6UvMPSHA2sgWnFP5
         lN+dYL1JGmtEq/lOSDXSUQWiHjOMa06epUVSlOdtxu5EYRm6E9DHmDZ39EqjX4uovjs1
         8Ot8gyBiYNVVg9YaE3+dmkOfH8oWAJYAhOCm4ZVeENc/2Dx04A1oixQdUw3e6aJyVTZA
         erGAXMHJ7o7Zg0q5NZxAQZxwH/rnzLDkpB5PRwUD5RRjrFLK+ZnRR86O5PId8GVBhP+g
         VCbA==
X-Gm-Message-State: APjAAAUApj7buhOLTyFJZD+4B5jA8JUSkDzUs7odsyxymNCeTrvypc8L
        y7bqKgu/rFRyF6U9Z4pSpvAFs4q1OJYCoY1HcIqi18Bo
X-Google-Smtp-Source: APXvYqz0uWsugdX3fasAhfKy/3p7tlWt0iLS1cZzwqJhKhd7WGC+IFaUB1uXnZBg/lNKzSSt3dH08bmMCbjfDTHiTeo=
X-Received: by 2002:ac2:5a44:: with SMTP id r4mr27941899lfn.118.1564695706755;
 Thu, 01 Aug 2019 14:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190801213922.158860-1-joel@joelfernandes.org>
In-Reply-To: <20190801213922.158860-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 1 Aug 2019 17:41:35 -0400
Message-ID: <CAEXW_YTp0UxtYGb5qZfVEpotfYvcYfjYj5Ob1M93Uidju6GxOw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Doc updates to /dev branch
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 5:39 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> This series fixes the rcu/dev branch with the new ReST conversion patches.
>

And as always, the patch 3/7 made it only to patchwork ;-)
https://lore.kernel.org/patchwork/patch/1109660/
