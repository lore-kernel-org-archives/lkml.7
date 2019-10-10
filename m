Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B970BC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 19:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8171B20659
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 19:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570734529;
	bh=0jkUH/Ad2OiIhYq+UOG5EPpU3+ItDjbe0bA9hPWEABQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=laPv8dl13QUJEas8vRxr2TWDRVcGnqVM6IEhFtFFpzIy9212vTeo4dqsiIXEhD6x/
	 lwfE7qAdBXltpgVXfV10LgGLOfRaXjEgC0OZ1j9wJehqIDQyoFIoyn/sPbti3KrYgy
	 w9g3BT30AZtF3WnCQ6FlLJG2OLqt0UkQIkR4F7iY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfJJTIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 15:08:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbfJJTIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 15:08:48 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3878020659;
        Thu, 10 Oct 2019 19:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570734527;
        bh=0jkUH/Ad2OiIhYq+UOG5EPpU3+ItDjbe0bA9hPWEABQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=tYwoHJF2sL0ZTl80fRjeidFIPf172r/LoZb11riLsNH7WnxtAxCaosYOecm3ku29/
         WEJWRywHMiVuf6C3AM5RwRJ17aZDqaJoECI1hnUjT6SrAg84YjxNj7116dzvNm6D+4
         Iv+xjRz3OhN5RTL648NFWMen0OJfkgU6hRVx9J7s=
Date:   Thu, 10 Oct 2019 21:08:17 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        dtor@chromium.org, ikjn@chromium.org
Subject: Re: [PATCH 1/2] HID: google: add magnemite/masterball USB ids
In-Reply-To: <20191003031800.120237-1-drinkcat@chromium.org>
Message-ID: <nycvar.YFH.7.76.1910102108020.13160@cbobk.fhfr.pm>
References: <20191003031800.120237-1-drinkcat@chromium.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2019, Nicolas Boichat wrote:

> Add 2 additional hammer-like devices.

Applied to for-5.4/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs

