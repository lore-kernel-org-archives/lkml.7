Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADABC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0BA21850
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfGZOPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:15:44 -0400
Received: from ms.lwn.net ([45.79.88.28]:50346 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbfGZOPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:15:44 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 03F8C2B7;
        Fri, 26 Jul 2019 14:15:43 +0000 (UTC)
Date:   Fri, 26 Jul 2019 08:15:42 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: phy: Drop duplicate 'be made'
Message-ID: <20190726081542.68e181f7@lwn.net>
In-Reply-To: <37eecffe6ecd9d64bfdb57a32f34b2c0805dd754.1564134855.git.agx@sigxcpu.org>
References: <37eecffe6ecd9d64bfdb57a32f34b2c0805dd754.1564134855.git.agx@sigxcpu.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 11:55:34 +0200
Guido Günther <agx@sigxcpu.org> wrote:

> Fix duplicate words.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Applied, thanks.

jon
