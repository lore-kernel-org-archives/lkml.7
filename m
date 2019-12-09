Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64033C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2371A2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="pk77XMTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfLIIpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 03:45:01 -0500
Received: from mx1.riseup.net ([198.252.153.129]:35724 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfLIIpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 03:45:00 -0500
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 47WcFm1P00zDrTD
        for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2019 00:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1575881100; bh=rECP+XlLZk/ggncFYtwe2zQD/k3a47VHBkv8utHOHBs=;
        h=Date:From:To:Subject:In-Reply-To:References:Reply-To:From;
        b=pk77XMTiBS6bGTHv+vSHlQhMHXKYMqtyyXos6ex9WQYCABnIFsnSWCVV0ge2mA8py
         pV11NAt8wgRKYVF5lNLqfcAFXkSjM3omDzq0x5EwdAtHINMiO83IThoB0JiSshQ5qg
         yP58qJF5QQyHAjNCncYfbJIVx/h+eZRUQfyZ6sNc=
X-Riseup-User-ID: C98F8C6519189001D8F3EC788B1BB774F9A608C91D384D2C14A601E2FAA79ECC
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 47WcFl4HBXz8tpS
        for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2019 00:44:59 -0800 (PST)
Date:   Mon, 9 Dec 2019 10:44:55 +0200
From:   Kernel User <linux-kernel@riseup.net>
To:     linux-kernel@vger.kernel.org
Subject: Re: CPU vulnerabilities and web JavaScript
Message-ID: <20191209104455.2fbbcd4c@localhost>
In-Reply-To: <20191208214958.492988dd@localhost>
References: <20191208214958.492988dd@localhost>
Reply-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anybody?
Please.
