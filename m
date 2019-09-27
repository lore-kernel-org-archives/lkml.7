Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B471C352AB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 05:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653AE21783
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 05:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569562597;
	bh=AaRZAAlTXRa6HzUc0TcRfYdF4U//0dh1f6GVRjtdT64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ShG/7U6Poi6jVU7H89AYzdXn6uLWKU97PmErA0j/hYBot/CRP9Fviel6K64V7OTCy
	 LkyCJLPEQdYL2E4xO6eU6DzO7d93F6pag/hV36LdAEhFl7a97orxDY92ZTR/BKL9H/
	 TZHazEzWM032sUj8zxd7BbXxZLdlq4GhfIQt7rfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfI0Fgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 01:36:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfI0Fgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 01:36:36 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E60B820872;
        Fri, 27 Sep 2019 05:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569562595;
        bh=AaRZAAlTXRa6HzUc0TcRfYdF4U//0dh1f6GVRjtdT64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MmPouLzO1AloZYDCYZu959oelmYr2TFKqPbkG/T5KJNEaySqKzwzVfqKVZuL+TEQt
         fEHNTanygIfu675qmcBICXp9vjMrYPMXSwIJ5XbhB6Mo5sHlfopkjOv7T0gUTOmDbT
         mrDK0FCHiBx632rk1jxOA9GIsJW10NIPsZOWEbGo=
Date:   Fri, 27 Sep 2019 07:36:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PM / Domains: Add tracepoints
Message-ID: <20190927053632.GB1781519@kroah.com>
References: <20190926150406.v1.1.I07a769ad7b00376777c9815fb169322cde7b9171@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926150406.v1.1.I07a769ad7b00376777c9815fb169322cde7b9171@changeid>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 03:04:38PM -0700, Matthias Kaehlcke wrote:
> Define genpd_power_on/off and genpd_set_performance_state
> tracepoints and use them.

This says _what_ you do, but not _why_ you want to do this.  Who is
going to use this?  What can be done with this information that is
needed by anyone/someone?

More details please.

thanks,

greg k-h
