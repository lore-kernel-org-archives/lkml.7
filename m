Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071FAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A372082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfDDNZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:25:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:8633 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728841AbfDDNZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:25:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 06:25:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,308,1549958400"; 
   d="scan'208";a="161351391"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 04 Apr 2019 06:25:28 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 04 Apr 2019 16:25:28 +0300
Date:   Thu, 4 Apr 2019 16:25:28 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Yu Chen <chenyu56@huawei.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        suzhuangluan@hisilicon.com, kongfei@hisilicon.com,
        liuyu712@hisilicon.com, wanghu17@hisilicon.com,
        butao@hisilicon.com, chenyao11@huawei.com,
        fangshengzhou@hisilicon.com, lipengcheng8@huawei.com,
        songxiaowei@hisilicon.com, xuyiping@hisilicon.com,
        xuyoujun4@huawei.com, yudongbin@hisilicon.com,
        zangleigang@hisilicon.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 08/13] usb: roles: Introduce stubs for the exiting
 functions in role.h.
Message-ID: <20190404132528.GD21319@kuha.fi.intel.com>
References: <20190329041409.70138-1-chenyu56@huawei.com>
 <20190329041409.70138-9-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329041409.70138-9-chenyu56@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 12:14:04PM +0800, Yu Chen wrote:
> This patch adds stubs for the exiting functions while
> CONFIG_USB_ROLE_SWITCH does not enabled.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  include/linux/usb/role.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
> index c05ffa6abda9..da2b9641b877 100644
> --- a/include/linux/usb/role.h
> +++ b/include/linux/usb/role.h
> @@ -42,6 +42,8 @@ struct usb_role_switch_desc {
>  	bool allow_userspace_control;
>  };
>  
> +
> +#if IS_ENABLED(CONFIG_USB_ROLE_SWITCH)
>  int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role);
>  enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw);
>  struct usb_role_switch *usb_role_switch_get(struct device *dev);
> @@ -51,5 +53,33 @@ struct usb_role_switch *
>  usb_role_switch_register(struct device *parent,
>  			 const struct usb_role_switch_desc *desc);
>  void usb_role_switch_unregister(struct usb_role_switch *sw);
> +#else
> +static inline int usb_role_switch_set_role(struct usb_role_switch *sw,
> +		enum usb_role role)
> +{
> +	return 0;
> +}
> +
> +static inline enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw)
> +{
> +	return USB_ROLE_NONE;
> +}
> +
> +static inline struct usb_role_switch *usb_role_switch_get(struct device *dev)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +static inline void usb_role_switch_put(struct usb_role_switch *sw) { }
> +
> +static inline struct usb_role_switch *
> +usb_role_switch_register(struct device *parent,
> +			 const struct usb_role_switch_desc *desc)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +static inline void usb_role_switch_unregister(struct usb_role_switch *sw) { }
> +#endif
>  
>  #endif /* __LINUX_USB_ROLE_H */
> -- 
> 2.15.0-rc2

thanks,

-- 
heikki
