Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A545C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110B8206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfCTSYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:24:33 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:35029 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfCTSYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:24:32 -0400
Received: from [192.168.1.110] ([95.115.36.242]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MHGTI-1hB7ry1Bnk-00DD9y; Wed, 20 Mar 2019 19:24:22 +0100
Subject: Re: [PATCH] Respond:add support for SUNIX Multi-I/O board
To:     Morris Ku <saumah@gmail.com>, gregkh@linuxfoundation.org
Cc:     morris_ku@sunix.com, linux-kernel@vger.kernel.org, arnd@arndb.de
References: <20190315100614.25027-1-saumah@gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <ef1abb26-4c88-1b11-da25-f6891bee0e21@metux.net>
Date:   Wed, 20 Mar 2019 19:24:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190315100614.25027-1-saumah@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:EWd6pJsMxjH+0N/ffstVZWj2uAu5ls+nXy6FEt1idU0v0lqHOIF
 pE1G7JFNrc0yhnAKOtCSyggqkfhAyHnmuBUt6V4Ig8C51w5TFmfyYV52/yhyntvMZOiPHSY
 cxAMlEv8CdZGLTycLvGQVAOaThq8clEWGKS1+CsMX53Ae7PzVXmorXNV/VkkWAwi1aYG2B9
 PibUYd2k0Oud54635mtXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IXWLk0kDyIY=:V48e6AwYk+DknXWD2+bHg/
 oGebGra1wMexiqfvKJFhdU6f70/6dQgcSc60e1hfCEe9GlzYTc3g1+7pBXym8SNUwjcm26k/G
 qWwNsjgjr8+CBVWwUZZuto/yNOc6XMfsn/hPLloyMjZv3WoC3BqYz0sQDJBiFceYsmtX1qmYQ
 WCvBOdT7kNskqT4R9VvSm0k9QohKH5K64b/UsGxzVq18R13YIlUrD2EIMpU/xTyK5XP1bb3wd
 mAOWK3I1gdw7Om9R4VhQLCgmg+hypacsEoinoLd2U0YhsJ6Hc++TjcDqYBD7MaxJrGzkY+Rd1
 GRyaDDczdC/k8Z+1nh4j99UFtADhYApKyJpiLdfAxo/hWDWYNhJggyNZ+cDqS9a8cG+jQS4Iy
 tZ/vYrSdJwLC89fHXsrHsZT0SSxtiFZrIcvEzYjR+GL1R84ucNTlImwIfbCJew6ejkHYZoTKe
 h+GT/VzRsQ4HNx8VMy2i86neNIc1eu7V7nC/3QIvBkXEtKvYuMnK7gfZytdztxe7dswdI4tWm
 /NCTBt5KbamtvYa0IwNhSXcgX0507q4xnsERL8n7j1bo16SO5+8VTDvRvhdj7ttTueA0i78yP
 vehjXQ3XhyzQOtdc1JUcaHN8E5hIj0Urwb8xCieJLzlUjQIlSktEBn246CWrq7Sds2QnEGr0K
 7BqfP178KNLrI9t0ax44EJNW8SQv8k98PQcyfKoR2xMmXJbjp/y9vjiVMp7N2R5/cI7R0IFD2
 5cLXHOvZo+XXlMmq+S9hkj8EoUmLzT64ux5vZGgUvPL687X8h5XwiDzak10=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.19 11:06, Morris Ku wrote:

Hi Morris,

> +Oh, is there really a hard restriction on the max number of boards ?
> +
> +driver support maximum 4 boards can be installed incombination
> +(up to 32 serial port and 2 parallel port)

Could somebody install more than 4 boards in a machine ?

Is there any problem w/ having this data allocated per board,
associating it to the corresponding struct device instance ?

You do know that - when using probe'able bus'es (eg. PCI) - the kernel
automatically creates device instances (per card) for you ? You just
have to register a driver w/ a table of the supported device IDs, and
the kernel will instantiate a device for you, finally calling the
probe() function to do the actual initialization.

For PCI, an easily understandable example could be pata_cmd640.c.
The other bus'es work in a similar way, even platform devices (those
which usually aren't on a probe'able bus) when using oftree or acpi.

> +> +static int snx_ser_port_total_cnt;
> +> +static int snx_par_port_total_cnt;
> +> +
> +> +int snx_board_count;
> +> +
> +> +static struct snx_ser_driver sunix_ser_reg = {
> +> +     .dev_name = "ttySNX",
> +> +     .major = 0,
> +> +     .minor = 0,
> +> +     .nr = (SNX_SER_TOTAL_MAX + 1),
> +> +};
> +
> +can't this be const ?
> +
> i prefer keep it in current format.

Why ? do you ever have to write into this struct ?

> +> +static irqreturn_t sunix_interrupt(int irq, void *dev_id)
> +> +{
> +> +     struct sunix_ser_port *sp = NULL;
> +> +     struct sunix_par_port *pp = NULL;
> +> +     struct sunix_board *sb = NULL;
> +> +     int i;
> +
> +> +     int status = 0;
> +> +
> +> +     int handled = IRQ_NONE;
> +> +
> +> +     for (i = 0; i < SNX_BOARDS_MAX; i++) {
> +> +
> +> +             if (dev_id == &(sunix_board_table[i])) {
> +> +                     sb = dev_id;
> +> +                     break;
> +> +             }
> +> +     }
> +
> +maybe put this index into the board data, so the loop on the global
> +array isn't needed ?
> +
> i prefer keep it in current format.

The code would be much cleaner if you'd just pass the pointer to the
corresponding struct sunix_board to (devm_)register_irq - this pointer
will then be passed as the second argument (dev_id) of the irq handler.
No need to scan the whole array, you'll directly get the right pointer.

> +<snip>
> +
> +> +     if ((sb->ser_port > 0) && (sb->ser_isr != NULL)) {
> +> +             sp = &sunix_ser_table[sb->ser_port_index];
> +
> +maybe put this pointer struct sunix_board so the lookup in the
> +global array isn't necessary ?
> +
> i prefer keep it in current format.

You do know that irq handlers should be as quick as possible ?
So, try to skip any unnecessary table scans.

> +<snip>
> +
> +> +     if ((sb->par_port > 0) && (sb->par_isr != NULL)) {
> +> +             pp = &sunix_par_table[sb->par_port_index];
> +> +
> +> +             if (!pp)
> +> +                     status = 1;
> +> +
> +> +             status = sb->par_isr(sb, pp);
> +> +     }
> +> +
> +> +     if (status != 0)
> +> +             return handled;
> +> +
> +> +     handled = IRQ_HANDLED;
> +> +     return handled;
> +> +}
> +
> +btw: is there only one irq per board or one per port ?
> +
> only one irq per board.

That is very unfortunate. if there was one per port, you could register
one handler per port and let the kernel directly route to the right port
instance. (see above: let it directly pass the pointer to the port data)

Are there other devices on the board that share the same irq ?

> +if it already is a global, why not statically initialized ?
> +Why not doing this in snx_pci_probe() on per-board basis, and let device
> +registration be done by pci subsystem ?
> +
> i prefer keep it in current format.

See above: when probing on per board-basis, the pci subsystem already
handles most of the stuff for you, and the driver becomes smaller and
easier to understand.

> SUNIX has many differing cards,serail,parallel and
> multi-i/o(serial + parellel), therefore, we combaine to one driver.

But we have entirely different subsystems for the different device
types, which take care of the corresponding kernel-internal and userland
APIs. Therefore, for such a multi function device, you'd actually have
several drivers, registering in the corresponding subsystem. A serial
driver registering in the serial subsystem, a gpio driver in the gpio
subsystem, etc ...

This is important! This is how hardware is used on Linux: we have one
API per device class, not hundreds, one for each device type or
manufacturer. This is exactly one of the major aspects that make Linux
so extremly universal and easily maintainable.

Nobody seriously wants to have hardware/manufacturer specific APIs.

> +<snip>
> +
> +> +             if ((gpio_ch_cnt == 0x00) && (gpio_card_type == 0x01))
> +> +                     gpio_ch_cnt = 6;
> +> +             else if ((gpio_ch_cnt == 0x00) && (gpio_card_type == 0x02))
> +> +                     gpio_ch_cnt = 8;
> +> +             else if (gpio_ch_cnt == 0x01)
> +> +                     gpio_ch_cnt = 16;
> +> +             else if (gpio_ch_cnt == 0x02)
> +> +                     gpio_ch_cnt = 32;
> +> +
> +
> +gpio devices have their own subsystem -> therefore: write a separate
> +gpio driver for that.
> +
> ioctl functions support for SUNIX specific serial,parellel and cash drawer
> interface.

As said: nobody likes hardware specific APIs.

> driver support maximum 4 boards can be installed incombination
> (up to 32 serial port and 2 parallel port)

Why this limitation ? Why just 4, not 8 or 16 ? Sounds pretty arbitrary.

> +> +static void __exit snx_exit(void)
> +> +{
> +> +     if (snx_par_port_total_cnt > 0) {
> +> +             sunix_par_lp_exit();
> +> +             sunix_par_ppdev_exit();
> +> +             sunix_par_parport_exit();
> +> +     }
> +
> +Let the cleanup be done by the individual driver's release functions,
> +and down forget to set .owner correctly - that way, the kernel won't
> +even allow unloading the module, as long as it's in use. then, you'd
> +probably don't need much more than just removing unregistering the
> +drivers here.
> +
> i prefer keep it in current format.

This isn't quite how the LDM works. You should be aware that drivers can
be unbound and rebound by the operator any time, even if the card
remains physically plugged (eg. important for things like PCI passthrough.)

Your driver doesn't support that (smells even like unpredictable
behaviour when somebody tries it), without giving any good reason.

> +> +static int EEPROMWriteData(int targetConfigAddress, int address, int data)
> +
> +why do you use int instead of void* for addresses ?
> +oh, and shouldn't it be __iomem ?
> +
> +targetConfigAddress for PCI (bar)base address register.

No, I was asking about the __iomem qualifier.

https://stackoverflow.com/questions/19100536/what-is-the-use-of-iomem-in-linux-while-writing-device-drivers

> +why this explicit check for CAP_SYS_ADMIN ?
> +
> check users with admin rights

Why exactly is that extra check needed ?
Are you aware of how filesystem permissions on device nodes work ?

> +why is userland allowed to change irq, port, etc, if that's probed
> +from pci anyways ?
> +
> +
> Since changing the 'type' of the port changes its resource
> allocations, we should treat type changes the same as
> IO port changes.

What exactly do you mean by 'type' ?
Anyways, userland shouldn't have access to such settings.

You should be away that it's very common to give certain unprivileged
users access to such devices, just via filesystem permissions (that's
eg. what the group 'dialout' is for). Therefore: don't allow any
potentially harmful operations here.

> +> +static int snx_ser_ioctl(struct tty_struct *tty,
> +> +unsigned int cmd, unsigned long arg)
> +> +{
> +<snip>
> +> +     case TIOCSSERIAL:
> +> +     {
> +> +             if (line < SNX_SER_TOTAL_MAX) {
> +> +                     state->port->setserial_flag = SNX_SER_BAUD_SETSERIAL;
> +> +                     ret = snx_ser_set_info(state,
> +> +                             (struct serial_struct *)arg);
> +> +             }
> +> +             break;
> +> +     }
> +> +
> +> +
> +> +     case TCSETS:
> +> +     {
> +> +             if (line < SNX_SER_TOTAL_MAX) {
> +> +                     state->port->flags &= ~(SNX_UPF_SPD_HI |
> +> +                             SNX_UPF_SPD_VHI |
> +> +                             SNX_UPF_SPD_SHI |
> +> +                             SNX_UPF_SPD_WARP);
> +> +                     state->port->setserial_flag = SNX_SER_BAUD_NOTSETSER;
> +> +                     snx_ser_update_termios(state);
> +> +             }
> +> +             break;
> +> +     }
> +> +
> +
> +Why do you need your own implementation of these tty ioctl()'s ?
> +The tty subsystem handles them on its own (using the callbacks for hw-
> +specific operations)
> +
> ioctl functions support for SUNIX specific serial,parellel and cash drawer interface.

As already set: the serial subsystem already handles that for you.
Don't reimplement existing standard functionality yourself, in your
special own way.

> +> +     case SNX_SER_DUMP_PORT_INFO:
> +<snip>
> +> +     case SNX_SER_DUMP_DRIVER_VER:
> +<snip>
> +> +     case SNX_COMM_GET_BOARD_CNT:
> +<snip>
> +> +     case SNX_COMM_GET_BOARD_INFO:
> +
> +is it really necessary to introduce your own driver-specific ioctl() ?
> +why not putting these things into debugfs or sysfs ?
> +
> ioctl functions support for SUNIX specific serial,
> parellel and cash drawer interface.

As already said: we have our own systems for that kind of functionality.
Don't reimplement existing standard functionality yourself, in your
special own way.

> +> +     case SNX_UART_SET_TYPE: {
> +
> +what is this for ?
> +
> +<snip>
> +
> +> +     case SNX_UART_SET_ACS:
> +
> +what is "ACS" ?
> +
> RS485 ACS Enable,Enable SUNIX UART Controller waiting transmit
> data when receive data is going.

IMHO serial subsystem should already have standard functionality for
that. Greg (the serial subsystem maintainer) probably can tell you
more about that.

> +> +extern int sunix_ser_register_driver(struct snx_ser_driver *drv)
> +> +{
> +> +     struct tty_driver *normal = NULL;
> +> +     int i;
> +> +     int ret = 0;
> +> +
> +> +     drv->state = kmalloc(sizeof(struct snx_ser_state) * drv->nr,
> +> +             GFP_KERNEL);
> +> +
> +> +     ret = -ENOMEM;
> +> +
> +> +     if (!drv->state) {
> +> +             pr_err("SNX Error: Allocate memory fail !\n\n");
> +> +             goto out;
> +> +     }
> +> +
> +> +     memset(drv->state, 0, sizeof(struct snx_ser_state) * drv->nr);
> +> +
> +> +     for (i = 0; i < drv->nr; i++) {
> +> +             struct snx_ser_state *state = drv->state + i;
> +> +             struct tty_port *tport = &state->tport;
> +> +
> +> +             tty_port_init(tport);
> +
> +does that really need to be globally in driver init, instead of in per
> +port device->open (and use device's private data) ?
> +
> i prefer to keep current format.

The standard Linux method is to do that in the corresponding probe()
function.

> +> +extern void sunix_ser_unregister_ports(struct snx_ser_driver *drv)
> +
> +why are these 'extern' ?!
> +
> functions definition in multiple .c files.

for functions, rototype w/ extern is sufficient.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
