Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B60C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DFB229F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfGXJCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 05:02:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:55758 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726207AbfGXJCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 05:02:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ED048AF59;
        Wed, 24 Jul 2019 09:02:07 +0000 (UTC)
Date:   Wed, 24 Jul 2019 11:02:06 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Cooks <acooks@rationali.st>, linux-acpi@vger.kernel.org,
        platypus-sw@opengear.com, "Tobin C . Harding" <me@tobin.cc>,
        Will Wagner <willw@carallon.com>
Subject: Re: [RESEND][PATCH v4 1/3] i2c: piix4: Fix port selection for AMD
 Family 16h Model 30h
Message-ID: <20190724110206.3c1ea315@endymion>
In-Reply-To: <20190724103748.078eab19@endymion>
References: <cover.1519601860.git.andrew.cooks@opengear.com>
        <be68c29f603153cf047cd893c6b9d6423073632d.1519601860.git.andrew.cooks@opengear.com>
        <20190724103748.078eab19@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2019 10:37:48 +0200, Jean Delvare wrote:
> Hi Andrew,
> 
> Sorry for the delay... What can I say :(

Unfortunately by now Andrew is gone. So I will be the one rebasing and
resubmitting this series.

-- 
Jean Delvare
SUSE L3 Support
