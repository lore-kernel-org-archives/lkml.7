Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFC1C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2038E2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564479373;
	bh=LtK0QokkgoTJFQdUYjV/Zz1SbLz9j29LgAK8gpHpfwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ssjoUc81W4hS9NCkeexucU4PgF45DzU1lqTqTD9KcIRtzyP5jYMZFMoTAS4/2ghBe
	 WP4HhjapNpwHY8NWYdtN1xSjJU0DW7qGIsBVjSd8MoUyS7Rt/FZ8i5iTc+it5kJAMb
	 xHbo8NHcUUDE2OLNnuSSX2QTqXhfoBwYU2HmluvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbfG3JgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:36:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730914AbfG3JgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:36:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8EC820665;
        Tue, 30 Jul 2019 09:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564479368;
        bh=LtK0QokkgoTJFQdUYjV/Zz1SbLz9j29LgAK8gpHpfwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yKBR09lRo6LmJGhQH2qUhOlfyCfidX+msWyCgzer5fjJe+3pEJNN9NJi3GpSBt7QA
         uMXxUydOtqI56KdD1v9UjS9UBrs6hizJxU4qOdHy3yoLnJzW02CNEYb3YkPG2f+7l0
         UiOCsKUprxlKMT0imfSNZdVCV4Jk6sWBhm3iB4bo=
Date:   Tue, 30 Jul 2019 11:36:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     Matt.Sickler@daktronics.com, devel@driverdev.osuosl.org,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees][PATCH v4] staging: kpc2000: Convert
 put_page to put_user_page*()
Message-ID: <20190730093606.GA15402@kroah.com>
References: <20190730092843.GA5150@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730092843.GA5150@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 02:58:44PM +0530, Bharath Vedartham wrote:
> put_page() to put_user_page*()

What does this mean?
